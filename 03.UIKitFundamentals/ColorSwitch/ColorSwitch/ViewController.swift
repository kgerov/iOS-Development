//
//  ViewController.swift
//  ColorSwitch
//
//  Created by Konstantin Gerov on 6/23/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var redColor: UISlider!
    @IBOutlet var greenColor: UISlider!
    @IBOutlet var blueColor: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    }
    
    @IBAction func changeViewColor(Sender: AnyObject)
    {
        let redValue = CGFloat(redColor.value)
        let greenValue = CGFloat(greenColor.value)
        let blueValue = CGFloat(blueColor.value)
        self.colorView.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}

