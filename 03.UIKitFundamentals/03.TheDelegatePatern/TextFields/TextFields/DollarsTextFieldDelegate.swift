//
//  DollarsTextFieldDelegate.swift
//  TextFields
//
//  Created by Konstantin Gerov on 7/2/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import UIKit

class DollarsTextFieldDelegate : NSObject, UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let invalidCharacters = NSCharacterSet.decimalDigitCharacterSet().invertedSet
        
        var newText = textField.text! as NSString
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)

        // Remove dollar sign and dot
        let dollarRange = newText.rangeOfString("$", options: NSStringCompareOptions.CaseInsensitiveSearch)
        newText = newText.stringByReplacingCharactersInRange(dollarRange, withString: "")
        let dotRange = newText.rangeOfString(".", options: NSStringCompareOptions.CaseInsensitiveSearch)
        newText = newText.stringByReplacingCharactersInRange(dotRange, withString: "")
        
        // Check if only numbers were entered
        if newText.rangeOfCharacterFromSet(invalidCharacters).location != NSNotFound {
            return false
        }
        
        var result = newText as String
        
        // Less then 3 digits
        if newText.length < 3 {
            let zerosToBeInserted = 3 - newText.length
            
            for _ in 1...zerosToBeInserted {
                result = "0" + result
            }
        } else {
            var leadingZerosCount = 0
            var index = result.startIndex
            
            while result[index] == "0" {
                leadingZerosCount += 1
                index = result.startIndex.advancedBy(leadingZerosCount)
            }
            
            while leadingZerosCount > 0 && result.characters.count > 3 {
                result.removeAtIndex(result.startIndex)
            }
        }
        
        // Insert dot and dollar sign
        result = "$" + result
        
        let dotIndex = result.endIndex.advancedBy(-2)
        result.insert(".", atIndex: dotIndex)
        
        textField.text = result
        return false
    }
}