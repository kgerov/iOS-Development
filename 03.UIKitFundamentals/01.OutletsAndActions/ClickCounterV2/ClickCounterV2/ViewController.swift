//
//  ViewController.swift
//  ClickCounterV2
//
//  Created by Konstantin Gerov on 6/23/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter = 0
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func incrementCounter() {
        counter += 1
        label.text = "\(counter)"
    }
}

