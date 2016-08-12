//
//  NotificationCenter.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class NotificationCenter : NSObject {

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
            controller.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}