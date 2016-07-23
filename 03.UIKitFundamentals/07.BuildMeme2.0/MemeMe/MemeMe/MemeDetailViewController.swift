//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/23/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class  MemeDetailViewController : UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memeImage!.image = meme.memeImage
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(editImage))
    }
    
    func editImage(){        
        // Present new controller modally
        var controller: MemeEditorViewController
        
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        controller.meme = meme
        self.navigationController!.presentViewController(controller, animated: true, completion: nil)
    }
}
