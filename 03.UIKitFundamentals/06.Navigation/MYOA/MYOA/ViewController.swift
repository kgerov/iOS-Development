//
//  ViewController.swift
//  MYOA
//
//  Created by Konstantin Gerov on 7/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Start Over",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: #selector(ViewController.startOver))
    }
    
    func startOver() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewControllerAnimated(true)
        }
    }
}

