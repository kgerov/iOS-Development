//
//  InputLocationViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit

class InputLocationViewController : UIViewController {
    
    var httpMethod: String?
    var studentAccount: StudentAccount?
    
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.getUserProfileData()
    }
    
    @IBAction func findLocationOnMap(sender: AnyObject) {
        
        guard locationTextField.text != nil else {
            NotificationCenter.displayError(self, message: "No location entered")
            return
        }
        
//        guard self.studentAccount != nil else {
//            NotificationCenter.displayError(self, message: "Haven't got user's profile data. Please, try again.")
//            return
//        }
        
        print(locationTextField.text)
        print(self.studentAccount)
        
        let address = locationTextField.text!
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            performUIUpdatesOnMain {
                guard error == nil else {
                    NotificationCenter.displayError(self, message: "Could not find geo location")
                    return
                }
                
                if let placemark = placemarks?.first {
                    let annotation = MKPlacemark(placemark: placemark)
                    
                    let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LinkInputViewController") as! LinkInputViewController
                    
                    controller.annotation = annotation
                    controller.studentAccount = self.studentAccount
                    controller.httpMethod = self.httpMethod
                    
                    self.presentViewController(controller, animated: true, completion: nil)

                }
            }
        })
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getUserProfileData() {
        
        UdacityClient.sharedInstance().getPublicUserData { (result, error) in
            
            performUIUpdatesOnMain {
                guard error == nil else {
                    NotificationCenter.displayError(self, message: "Could not get user's name")
                    return
                }
                
                self.studentAccount = result
            }
        }
    }
}
