//
//  DashboardViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class DashboardViewController : UIViewController {
    
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    @IBOutlet var dashboardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init theme
        darkThemeSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey("darkThemeOn")
        
        if darkThemeSwitch.on {
            dashboardView.backgroundColor = UIColor.grayColor()
        } else {
            dashboardView.backgroundColor = UIColor.whiteColor()
        }
    }
    
    
    @IBAction func changeTheme(sender: AnyObject) {
        
        if darkThemeSwitch.on {
            dashboardView.backgroundColor = UIColor.grayColor()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "darkThemeOn")
        } else {
            dashboardView.backgroundColor = UIColor.whiteColor()
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "darkThemeOn")
        }
    }
}

