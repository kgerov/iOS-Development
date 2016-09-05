//
//  NotificationCenter.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class NotificationCenter : NSObject {
    
    static let activityView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    static func displayError(controller: UIViewController, message: String) {
        let alertController = UIAlertController(title: nil, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    static func setUIEnabled(controller: UIViewController, enabled: Bool) {
        if !enabled {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .Alert)
            
            alert.view.tintColor = UIColor.blackColor()
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            controller.presentViewController(alert, animated: true, completion: nil)
        } else {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    static func activateActivityView(controller: UIViewController, activate: Bool) {
        
        if activate {
            activityView.center = controller.view.center
            activityView.startAnimating()
            controller.view.addSubview(activityView)
        } else {
            activityView.stopAnimating()
        }
    }
    
    static func displaySuccessRegistrationAlert(controller: UIViewController, overwriteHandler: (action: UIAlertAction!) -> Void) {
        
        let refreshAlert = UIAlertController(title: nil, message: "Registration successful. Login with your credentials.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: overwriteHandler))
    
        controller.presentViewController(refreshAlert, animated: true, completion: nil)
    }
}