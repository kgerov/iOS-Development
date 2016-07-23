//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/22/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MemeTableViewCell : UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    func addText(topText: String, bottomText: String) {
        memeText.text = topText + "..." + bottomText
        initLabel(self.topText, text: topText)
        initLabel(self.bottomText, text: bottomText)
    }
    
    private func initLabel(label: UILabel, text: String) {
        label.attributedText = NSAttributedString(string: "",
                                                  attributes: Constants.Storyboard.memeTextAttributes)
        label.textAlignment = NSTextAlignment.Center
    }
}
