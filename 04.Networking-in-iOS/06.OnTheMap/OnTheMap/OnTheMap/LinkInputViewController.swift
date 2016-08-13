//
//  LinkInputViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/13/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit

class LinkInputViewController : UIViewController {
    
    var annotation: MKPlacemark?
    
    @IBOutlet weak var linkTextField: LinkTextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.addAnnotation(annotation!)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        guard linkTextField.text != nil else {
            NotificationCenter.displayError(self, message: "Link field is empty")
            return
        }
        
        let key = UdacityClient.sharedInstance().userID
        let studentAccount = UdacityClient.sharedInstance().studentAccount
        let locationId = ParseClient.sharedInstance().locationId
        
        if locationId == nil {
            
            ParseClient.sharedInstance().createStudentLocation(key!, firstName: (studentAccount?.firstName)!, lastName: (studentAccount?.lastName)!, mapString: (self.annotation?.title)!, mediaUrl: self.linkTextField.text!, latitude: String(format: "%f", (self.annotation?.coordinate.latitude)!), longitude: String(format: "%f", (self.annotation?.coordinate.longitude)!), completionHandler: submitCompletionHandler)
        } else {
            
            ParseClient.sharedInstance().updateStudentLocation(locationId!, key: key!, firstName: (studentAccount?.firstName)!, lastName: (studentAccount?.lastName)!, mapString: (self.annotation?.title)!, mediaUrl: self.linkTextField.text!, latitude: String(format: "%f", (self.annotation?.coordinate.latitude)!), longitude: String(format: "%f", (self.annotation?.coordinate.longitude)!), completionHandler: submitCompletionHandler)
        }
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func submitCompletionHandler(success: Bool, error: NSError?) {
        performUIUpdatesOnMain {
            if success {
                let mapViewController = self.presentingViewController!.presentingViewController!
                
                mapViewController.dismissViewControllerAnimated(true, completion: {() in
                    let dataReloadable = mapViewController as? DataReloadable
                    dataReloadable!.reloadStudentLocations()
                })
            } else {
                NotificationCenter.displayError(self, message: "Failed to post location to server")
            }
        }
    }
}
