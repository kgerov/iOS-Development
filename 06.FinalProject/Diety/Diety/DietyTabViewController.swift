//
//  DietyTabViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class DietyTabViewController : UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavbarForViewControllers()
    }
    
    func setNavbarForViewControllers() {
        let mainController = self.viewControllers![0] as! UINavigationController
        let tableNavController = self.viewControllers![1] as! UINavigationController
        
        let viewControllers = [mainController.viewControllers[0],
                               tableNavController.viewControllers[0]]
        
        for controller in viewControllers {
            controller.title = "Diety"
            
            controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(self.logoutButtonPressed))
            
            let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: controller, action: #selector(self.addMeal))
            
            let rightBarButtonItems = [addButton]
            
            controller.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
        }
    }
    
    func logoutButtonPressed() {
        
        NotificationCenter.setUIEnabled(self, enabled: false, completion: nil)
        
        KinveyClient.sharedInstance().logout { (success, error) in
            
            NotificationCenter.setUIEnabled(self, enabled: true, completion: {
                if success {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    NotificationCenter.displayError(self, message: (error?.localizedDescription)!)
                }
            })
        }
    }
    
    func addMeal() {
        
    }
}