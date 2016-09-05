//
//  LoginViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        // Hide cursos and keyboard on touch
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text
            where username.isEmpty != true && password.isEmpty != true else {
                NotificationCenter.displayError(self, message: "Username or password field is empty.")
                return
        }
        
        NotificationCenter.setUIEnabled(self, enabled: false, completion: nil)
        
        KinveyClient.sharedInstance().login(username, password: password) { (success, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                NotificationCenter.setUIEnabled(self, enabled: true, completion: { 
                    if success {
                        
                        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("DietyTabViewController") as! UITabBarController
                        self.presentViewController(controller, animated: true, completion: nil)
                    } else {
                        NotificationCenter.displayError(self, message: (error?.localizedDescription)!)
                    }
                })
            }
        }
    }
}

extension LoginViewController {
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
