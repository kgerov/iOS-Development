//
//  LinkTextField.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/13/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class LinkTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
