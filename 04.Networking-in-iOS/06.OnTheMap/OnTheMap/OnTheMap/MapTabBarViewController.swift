//
//  MapTabBarViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MapTabBarViewController : UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavbarForViewControllers()
    }
    
    // MARK: - Helpers
    
    private func setNavbarForViewControllers() {
        
        let mapNavController = self.viewControllers![0] as! UINavigationController
        let tableNavController = self.viewControllers![1] as! UINavigationController
        
        let viewControllers = [mapNavController.viewControllers[0],
                               tableNavController.viewControllers[0]]
        
        for controller in viewControllers {
            controller.title = "Test"
            
            controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(self.logoutButtonPressed))
            
            let pinImage = UIImage(named: "Pin")
            let pinButton = UIBarButtonItem(image: pinImage, style: .Plain, target: self, action: #selector(self.newPinButtonPressed))
            
            let reloadButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: controller, action: #selector(reloadStudentLocations))
            
            let rightBarButtonItems = [reloadButton, pinButton]
            
            controller.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
        }
    }
    
    
    // MARK: - Navbar Button Actions
    
    func logoutButtonPressed() {
        print("logout")
    }
    
    func newPinButtonPressed() {
        print("new pin")
    }
    
    func reloadStudentLocations() {
        print("reload")
    }
}
