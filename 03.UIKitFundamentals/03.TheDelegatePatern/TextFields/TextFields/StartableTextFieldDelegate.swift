//
//  StartableTextFieldDelegate.swift
//  TextFields
//
//  Created by Konstantin Gerov on 7/2/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import UIKit

class StartableTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    var textFieldSwitch: UISwitch!
    
    internal init(textFieldSwitch: UISwitch) {
        super.init()
        self.textFieldSwitch = textFieldSwitch
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textFieldSwitch.on {
            return true
        }
        
        return false
    }

}