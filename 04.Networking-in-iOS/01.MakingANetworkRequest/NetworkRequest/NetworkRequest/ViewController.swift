//
//  ViewController.swift
//  NetworkRequest
//
//  Created by Konstantin Gerov on 7/25/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = NSURL(string: "https://upload.wikimedia.org/wikipedia/en/5/5f/Original_Doge_meme.jpg")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(imageUrl){ (data, response, error) in
        
            if error == nil {
                let image = UIImage(data: data!)
                
                performUIUpdatesOnMain {
                    self.imageView.image = image
                }
            }
        }
        
        task.resume()
    }
}

