//
//  InputLocationViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit

class InputLocationViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getUserProfileData()
        
        locationTextField.delegate = self
        
        // Hide cursos and keyboard on touch
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputLocationViewController.hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @IBAction func findLocationOnMap(sender: AnyObject) {
        
        guard locationTextField.text != nil else {
            NotificationCenter.displayError(self, message: "No location entered")
            return
        }
        
        NotificationCenter.activateActivityView(self, activate: true)
            
        let address = locationTextField.text!
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            performUIUpdatesOnMain {
                NotificationCenter.activateActivityView(self, activate: false)
                
                guard error == nil else {
                    NotificationCenter.displayError(self, message: "Could not find geo location")
                    return
                }
                
                if let placemark = placemarks?.first {
                    let annotation = MKPlacemark(placemark: placemark)
                    
                    let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LinkInputViewController") as! LinkInputViewController
                    
                    controller.annotation = annotation
                    
                    self.presentViewController(controller, animated: true, completion: nil)

                }
            }
        })
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getUserProfileData() {
        
        UdacityClient.sharedInstance().getPublicUserData { (result, error) in
            
            performUIUpdatesOnMain {
                guard error == nil else {
                    NotificationCenter.displayError(self, message: "Could not get user's name")
                    self.dismissViewControllerAnimated(true, completion: nil)
                    return
                }
            }
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
