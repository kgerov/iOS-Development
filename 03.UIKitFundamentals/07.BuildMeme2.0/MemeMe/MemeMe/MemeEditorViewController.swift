//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let memeDelegate = MemeTextFieldDelegate()
    var meme: Meme!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style for text fields
        addStyleToTextField(topTextField)
        addStyleToTextField(bottomTextField)
        
        // Hide cursos and keyboard on touch
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemeEditorViewController.hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Draw Meme on screen if in edit mode
        if meme != nil {
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            imageView.image = meme.originalImage
        }
        
        // Enable camera button if device has a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Subscribe to keyboard notification
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        ubsubscribeFromKeyboardNotifications()
    }
    
    // Hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        if sender.tag == 0 {
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memeImage = generateMemedImage()
        let shareItems: Array = [memeImage]
        let activityController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        activityController.excludedActivityTypes = [UIActivityTypePostToWeibo,
                                                    UIActivityTypeCopyToPasteboard,
                                                    UIActivityTypeAddToReadingList,
                                                    UIActivityTypePostToVimeo]
        
        activityController.completionWithItemsHandler = {
            (activity, success, items, error) in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMemeEditing(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            shareButton.enabled = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func ubsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = getKeyBoardHeight(notification) * (-1)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeyBoardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func save() {
        let memeImage = generateMemedImage()
        let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!,
                        originalImage: self.imageView.image!, memeImage: memeImage)
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage
    {
        // Hide toolbars and keyboard
        self.topToolbar.hidden = true
        self.bottomToolbar.hidden = true
        hideKeyboard()
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbars
        self.topToolbar.hidden = false
        self.bottomToolbar.hidden = false
        
        return memedImage
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func addStyleToTextField(textField: UITextField) {
        textField.defaultTextAttributes = Constants.Storyboard.memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textField.delegate = memeDelegate
    }
}

