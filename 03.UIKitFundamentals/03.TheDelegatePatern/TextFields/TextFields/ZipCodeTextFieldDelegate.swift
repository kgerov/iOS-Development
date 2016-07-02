//
//  ZipCodeTextFieldDelegate.swift
//  TextFields
//
//  Created by Konstantin Gerov on 7/2/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import UIKit

class ZipCodeTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let invalidCharacters = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        
        var newText = textField.text! as NSString
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        
        if newText.length > 5 {
            return false
        }
        
        if newText.rangeOfCharacterFromSet(invalidCharacters).location != NSNotFound {
            return false
        }
        
        return true
    }
}