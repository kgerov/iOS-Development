//
//  ViewController.swift
//  ClickCounter
//
//  Created by Konstantin Gerov on 6/22/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var counter = 0
    var label: UILabel!
    var labelCopy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label
        let label = UILabel()
        label.frame = CGRectMake(150, 150, 60, 60)
        label.text = "0"
        self.view.addSubview(label)
        self.label = label
        
        // Label Copy
        let labelCopy = UILabel()
        labelCopy.frame = CGRectMake(180, 150, 60, 60)
        labelCopy.text = "0"
        self.view.addSubview(labelCopy)
        self.labelCopy = labelCopy
        
        // Button
        let button = UIButton()
        button.frame = CGRectMake(150, 250, 60, 60)
        button.setTitle("Click", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.addTarget(self, action: #selector(ViewController.incrementCounter), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        // Decrement Button
        let decrButton = UIButton()
        decrButton.frame = CGRectMake(200, 250, 60, 60)
        decrButton.setTitle("Click", forState: .Normal)
        decrButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        decrButton.addTarget(self, action: #selector(ViewController.decementCounter), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(decrButton)
    }
    
    func incrementCounter() {
        counter += 1
        label.text = "\(counter)"
        labelCopy.text = "\(counter)"
        changeColor()
    }
    
    func decementCounter() {
        counter -= 1
        label.text = "\(counter)"
        labelCopy.text = "\(counter)"
        changeColor()
    }
    
    func changeColor() {
        let redColor = CGFloat(arc4random_uniform(101))/10
        let greenColor = CGFloat(arc4random_uniform(101))/10
        let blueColor = CGFloat(arc4random_uniform(101))/10
        self.view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }
}

