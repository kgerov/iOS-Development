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
    
    var httpMethod: String?
    var annotation: MKPlacemark?
    var studentAccount: StudentAccount?
    
    @IBOutlet weak var linkTextField: LinkTextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.addAnnotation(annotation!)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
