//
//  ViewController.swift
//  TextFields
//
//  Created by Konstantin Gerov on 6/29/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var dollarsField: UITextField!
    @IBOutlet weak var startableField: UITextField!
    @IBOutlet weak var textFieldSwitch: UISwitch!
    
    let zipCodeDelegate = ZipCodeTextFieldDelegate()
    var startableDelegate: StartableTextFieldDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startableDelegate = StartableTextFieldDelegate(textFieldSwitch: textFieldSwitch)
        self.zipCodeField.delegate = zipCodeDelegate
        self.startableField.delegate = startableDelegate
        
    }
}

