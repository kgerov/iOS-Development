//
//  ViewController.swift
//  ImagePicker
//
//  Created by Konstantin Gerov on 6/24/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func experiment() {
        alertViewExperiment()
    }
    
    private func imagePickerExperiment() {
        let nextController = UIImagePickerController()
        self.presentViewController(nextController, animated: true, completion: nil)
    }
    
    private func activityViewControllerExperiment() {
        let image = UIImage()
        let nextController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(nextController, animated: true, completion: nil)
    }
    
    private func alertViewExperiment() {
        let nextController = UIAlertController()
        nextController.title = "title alert"
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { action in
            self.dismissViewControllerAnimated(true, completion: nil)}
        
        nextController.addAction(okAction)
        self.presentViewController(nextController, animated: true, completion: nil)
    }
}

