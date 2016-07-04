//
//  Meme.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memeImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
}
