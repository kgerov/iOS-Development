//
//  MapTabBarViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MapTabBarViewController : UITabBarController, DataReloadable {

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
            controller.title = "On The Map"
            
            controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(self.logoutButtonPressed))
            
            let pinImage = UIImage(named: "Pin")
            let pinButton = UIBarButtonItem(image: pinImage, style: .Plain, target: self, action: #selector(self.newPinButtonPressed))
            
            let reloadButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: controller, action: #selector(reloadStudentLocations))
            
            let rightBarButtonItems = [reloadButton, pinButton]
            
            controller.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
        }
    }
    
    func redirectToPostPinView(action: UIAlertAction?) {
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InputLocationViewController") as! InputLocationViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: - Navbar Button Actions
    
    func logoutButtonPressed() {
        
        NotificationCenter.setUIEnabled(self, enabled: false)
        
        UdacityClient.sharedInstance().deleteSessionId { (success, error) in

            NotificationCenter.setUIEnabled(self, enabled: true)
            
            if success {
                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("loginViewController")
                self.presentViewController(controller, animated: true, completion: nil)
            } else {
                NotificationCenter.displayError(self, message: "Could not logout")
            }
        }
    }
    
    func newPinButtonPressed() {
        
        // Check if user has already posted a pin
        let userId = UdacityClient.sharedInstance().userID!
        
        ParseClient.sharedInstance().isUsersFirstPin(userId) { (pinId, error) in
            
            performUIUpdatesOnMain {
                guard error == nil else {
                    NotificationCenter.displayError(self, message: "Failed to check if this is user's first pin")
                    return
                }
                
                if pinId == nil {
                    self.redirectToPostPinView(nil)
                } else {
                    NotificationCenter.displayOVverwritePinAlert(self, overwriteHandler: self.redirectToPostPinView)
                }
            }
        }
    }
    
    func reloadStudentLocations() {
        
        let navController = self.selectedViewController as? UINavigationController
        let controller = navController?.visibleViewController as? DataReloadable
        controller?.reloadStudentLocations()
    }
}
