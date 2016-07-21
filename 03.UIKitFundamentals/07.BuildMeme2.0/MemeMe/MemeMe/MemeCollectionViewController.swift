//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController {

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = applicationDelegate.memes
    }
}
