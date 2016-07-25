//
//  ViewController.swift
//  NetworkRequest
//
//  Created by Konstantin Gerov on 7/25/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = NSURL(string: "https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg")
        
        NSURLSession.sharedSession()
    }
}

