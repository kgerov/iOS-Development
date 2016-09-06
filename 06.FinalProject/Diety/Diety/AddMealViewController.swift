//
//  AddMealViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class AddMealViewController : UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let mealTypes = [AppConstants.MealTypes.Breakfast, AppConstants.MealTypes.Brunch,
                     AppConstants.MealTypes.Lunch, AppConstants.MealTypes.Snack,
                     AppConstants.MealTypes.Dinner]

    var selectedRow = AppConstants.MealTypes.Breakfast
    
    @IBOutlet weak var titleTextField: LoginTextField!
    @IBOutlet weak var ingridientsTextField: LoginTextField!
    @IBOutlet weak var mealTypePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIPickerView
        self.mealTypePicker.dataSource = self;
        self.mealTypePicker.delegate = self;
        
        // UITextFieldDelegate
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
        
        print(title)
        print(ingridients)
        print(self.selectedRow)
        
        clearTextFields()
    }
    
    // MARK - PickerView Methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mealTypes.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mealTypes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedRow = self.mealTypes[row]
    }
    
    // MARK: - Helpers
    func clearTextFields() {
        self.titleTextField.text = ""
        self.ingridientsTextField.text = ""
        self.mealTypePicker.selectedRowInComponent(0)
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
