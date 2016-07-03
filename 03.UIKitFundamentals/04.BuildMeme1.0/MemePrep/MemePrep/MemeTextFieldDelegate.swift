//
//  MemeTextFieldDelegate.swift
//  MemePrep
//
//  Created by Konstantin Gerov on 7/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
