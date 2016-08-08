//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/7/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController {
    
    private let placeholderAttributes = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Roboto-Regular", size: 19)!
    ]
    
    @IBOutlet weak var debugField: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setCustomPlaceholderText()
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
    }
}

extension LoginViewController {
    
    private func setCustomPlaceholderText() {
        emailTextField.attributedPlaceholder =
            NSAttributedString(string:"Email", attributes: placeholderAttributes)
        passwordTextField.attributedPlaceholder =
            NSAttributedString(string:"Password", attributes: placeholderAttributes)
    }
}
