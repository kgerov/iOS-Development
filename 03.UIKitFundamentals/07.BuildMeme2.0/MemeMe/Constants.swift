//
//  Constants.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/23/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

struct Constants {
    struct Storyboard {
        static let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.3
        ]
        
        static let memeLabelAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
            NSStrokeWidthAttributeName : -3.3
        ]
    }
}