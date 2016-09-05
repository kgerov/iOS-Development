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
        
    }
}
