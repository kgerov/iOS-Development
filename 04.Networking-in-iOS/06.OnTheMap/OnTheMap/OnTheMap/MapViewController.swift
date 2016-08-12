//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
    let pinReusableId = "pin"
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeStudentLocationsOnMap()
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(self.pinReusableId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: self.pinReusableId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps.
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func placeStudentLocationsOnMap() {
        ParseClient.sharedInstance().getStudentLocations() { (result: [StudentInformation]?, error: NSError?) in
            
            guard error == nil else {
                self.displayError("Failed to get student locations")
                return
            }
            
            guard let result = result else {
                self.displayError("No student locations returned")
                return
            }
            
            let annotations = self.createAnnotationsFromStudentInformation(result)
            
            performUIUpdatesOnMain {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    private func createAnnotationsFromStudentInformation(studentsLocations: [StudentInformation]) -> [MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation]()
        
        for studentLocation in studentsLocations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = studentLocation.coordinate
            annotation.title = "\(studentLocation.firstName) \(studentLocation.lastName)"
            annotation.subtitle = studentLocation.mediaUrl
            
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    private func displayError(message: String) {
        let alertController = UIAlertController(title: "", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func reloadStudentLocations() {
        print("reload from map")
    }
}
