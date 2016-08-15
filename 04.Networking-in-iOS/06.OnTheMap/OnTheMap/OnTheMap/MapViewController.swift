//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate, DataReloadable {
    
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
            let toOpen = view.annotation?.subtitle!
            if  verifyUrl(toOpen) {
                app.openURL(NSURL(string: toOpen!)!)
            } else {
                NotificationCenter.displayError(self, message: "Invalud URL.")
            }
        }
    }
    
    // MARK: - Helpers
    
    private func verifyUrl (urlString: String?) -> Bool {
        
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        
        return false
    }
    
    func reloadStudentLocations() {
        
        ParseClient.sharedInstance().downloadStudentLocations(processStudentLocationData)
    }
    
    private func placeStudentLocationsOnMap() {
        ParseClient.sharedInstance().getStudentLocations(processStudentLocationData)
    }
    
    private func processStudentLocationData(result: [StudentInformation]?, error: NSError?) {
        performUIUpdatesOnMain {
            guard error == nil else {
                NotificationCenter.displayError(self, message: "Failed to get student locations")
                return
            }
            
            guard let result = result else {
                NotificationCenter.displayError(self, message: "No student locations returned")
                return
            }
            
            let annotations = self.createAnnotationsFromStudentInformation(result)        
        
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotations(annotations)
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
}
