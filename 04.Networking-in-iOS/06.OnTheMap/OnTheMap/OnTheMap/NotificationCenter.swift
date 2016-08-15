//
//  NotificationCenter.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
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
    
    static func displayOVverwritePinAlert(controller: UIViewController, overwriteHandler: (action: UIAlertAction!) -> Void) {
        
        let refreshAlert = UIAlertController(title: nil, message: "You have already posted a Student Location. Would you like to overwrite your current location.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Overwrite", style: .Default, handler: overwriteHandler))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        controller.presentViewController(refreshAlert, animated: true, completion: nil)
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
}