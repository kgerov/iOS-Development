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
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        setCustomPlaceholderText()
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        guard let username = emailTextField.text, let password = passwordTextField.text
            where username.isEmpty != true && password.isEmpty != true else {
            displayError("Email or password field is empty.")
            return
        }
        
        self.setUIEnabled(false)
        UdacityClient.sharedInstance().getSessionId(username, password: password, completionHandler: { (success, error) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    self.setUIEnabled(true)

                    NotificationCenter.displayError(self, message: (error?.localizedDescription)!)
                }
            }
        })
    }
    
    private func completeLogin() {
        self.setUIEnabled(false)
        debugField.text = ""
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapTabBarController") as! UITabBarController
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

extension LoginViewController {
    
    private func setUIEnabled(enabled: Bool) {
        loginButton.enabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            debugField.text = errorString
        }
    }
    
    private func setCustomPlaceholderText() {
        emailTextField.attributedPlaceholder =
            NSAttributedString(string:"Email", attributes: placeholderAttributes)
        passwordTextField.attributedPlaceholder =
            NSAttributedString(string:"Password", attributes: placeholderAttributes)
    }
}
