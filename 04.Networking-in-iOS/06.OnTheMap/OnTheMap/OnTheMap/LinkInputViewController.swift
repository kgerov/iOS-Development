//
//  LinkInputViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/13/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit

class LinkInputViewController : UIViewController, UITextFieldDelegate {
    
    var annotation: MKPlacemark?
    
    @IBOutlet weak var linkTextField: LinkTextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add annotation to map and zoom to annotation
        self.mapView.addAnnotation(annotation!)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        // Set text field delegate to this class
        linkTextField.delegate = self
        
        // Hide cursos and keyboard on touch
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputLocationViewController.hideKeyboard))
        view.addGestureRecognizer(tapRecognizer)
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
    
    // MARK: - Helpers
    
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
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
