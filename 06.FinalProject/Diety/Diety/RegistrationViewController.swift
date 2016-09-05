//
//  RegistrationViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class RegistrationViewController : UIViewController {
    
    @IBOutlet weak var usernameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var repeatedPasswordTextField: LoginTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text, let repeaedPassword = repeatedPasswordTextField.text
            where username.isEmpty != true && password.isEmpty != true && repeaedPassword.isEmpty != true else {
                NotificationCenter.displayError(self, message: "Username or password field is empty.")
                return
        }
        
        guard password == repeaedPassword else {
            
            NotificationCenter.displayError(self, message: "Passwords do not match.")
            return
        }
        
        NotificationCenter.setUIEnabled(self, enabled: false)
        
        KinveyClient.sharedInstance().register(username, password: password) { (success, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if success {
                    
                    KinveyClient.sharedInstance().login(username, password: password) { (success, error) in
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            NotificationCenter.setUIEnabled(self, enabled: true)
                            
                            if success {
                                
                                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("DietyTabViewController") as! UITabBarController
                                self.presentViewController(controller, animated: true, completion: nil)
                            } else {
                                NotificationCenter.displayError(self, message: (error?.localizedDescription)!)
                            }
                        }
                    }
                } else {
                    NotificationCenter.setUIEnabled(self, enabled: true)
                    NotificationCenter.displayError(self, message: (error?.localizedDescription)!)
                }
            }
        }
    }
}
