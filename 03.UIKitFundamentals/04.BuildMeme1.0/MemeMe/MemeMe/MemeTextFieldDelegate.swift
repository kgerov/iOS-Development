//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate : NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        var newText = textField.text! as NSString
        
        // Remove "TOP" and "BOTTOM" once users start to type text
        let topRange = newText.rangeOfString("TOP", options: NSStringCompareOptions.CaseInsensitiveSearch)
        newText = newText.stringByReplacingCharactersInRange(topRange, withString: "")
        let bottomRange = newText.rangeOfString("BOTTOM", options: NSStringCompareOptions.CaseInsensitiveSearch)
        newText = newText.stringByReplacingCharactersInRange(bottomRange, withString: "")
        
        textField.text = newText as String
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}