//
//  AddMealViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class AddMealViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: LoginTextField!
    @IBOutlet weak var ingridientsTextField: LoginTextField!
    @IBOutlet weak var mealTypePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        ingridientsTextField.delegate = self
        
        // Hide cursos and keyboard on touch
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        clearTextFields()
    }
    
    @IBAction func closeViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addMeal(sender: AnyObject) {
        
        guard let title = titleTextField.text, let ingridients = ingridientsTextField.text
            where title.isEmpty != true else {
                NotificationCenter.displayError(self, message: "Form is incomplete.")
                return
        }
        
        clearTextFields()
    }
    
    // MARK: - Helpers
    func clearTextFields() {
        self.titleTextField.text = ""
        self.ingridientsTextField.text = ""
    }
}

extension AddMealViewController {
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
