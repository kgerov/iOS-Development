//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController : UIViewController, MKMapViewDelegate {
    
    private var deleteModeOn: Bool = false
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deleteMessage: UILabel!
    
    var fetchedResultsController : NSFetchedResultsController?{
        didSet{
            // Whenever the frc changes, we execute the search and
            // reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
            self.placeLocationsOnMap()
        }
    }
    
    init(fetchedResultsController fc : NSFetchedResultsController) {
        
        fetchedResultsController = fc
        super.init(nibName: nil, bundle: nil)
    }
    
    // Do not worry about this initializer. I has to be implemented
    // because of the way Swift interfaces with an Objective C
    // protocol called NSArchiving. It's not relevant.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteModeOn = false
        
        // Add pins when tapping on map
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.tapOnMap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        // Init the fetch controller
        
        // Get the stack
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create a fetchrequest
        let fr = NSFetchRequest(entityName: "Location")
        fr.sortDescriptors = [NSSortDescriptor(key: "latitude", ascending: true),
                              NSSortDescriptor(key: "longitude", ascending: true)]
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr,
                                                              managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
    }
    
    @IBAction func removeButtonPressed(sender: AnyObject) {
        
        if self.deleteModeOn {
            
            self.deleteModeOn = false
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            setView(self.deleteMessage, hidden: true)
            
        } else {
            self.deleteModeOn = true
            self.navigationItem.rightBarButtonItem?.title = "Done"
            setView(self.deleteMessage, hidden: false)
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.canShowCallout = false
            pinView!.animatesDrop = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        if self.deleteModeOn {
            print("Delete pin")
        } else {
            print("Open location's album")
        }
    }
    
    // MARK: - Helpers
    
    func tapOnMap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.locationInView(mapView)
        let coordinate = mapView.convertPoint(location,toCoordinateFromView: mapView)
        
        // Add annotation:
        let annotation = Location(latitude: Double(coordinate.latitude), longitude: Double(coordinate.longitude), context: self.fetchedResultsController!.managedObjectContext)

        mapView.addAnnotation(annotation)
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transitionWithView(view, duration: 0.5, options: .TransitionCrossDissolve, animations: {() -> Void in
            view.hidden = hidden
            }, completion: { _ in })
    }
    
    func placeLocationsOnMap() {
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(self.fetchedResultsController!.fetchedObjects as! [Location])
    }
}

// MARK:  - Fetches
extension MapViewController{
    
    func executeSearch(){
        if let fc = fetchedResultsController{
            do{
                try fc.performFetch()
            }catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}

// MARK:  - Delegate
extension MapViewController: NSFetchedResultsControllerDelegate{
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        
        
        switch(type){
            
        case .Insert:
            self.fetchedResultsChangeInsert(anObject as! Location)
            
        case .Delete:
            self.fetchedResultsChangeDelete(anObject as! Location)
            
        case .Update:
            self.fetchedResultsChangeUpdate(anObject as! Location)
            
        case .Move:
            break
        }
        
    }
    
    func fetchedResultsChangeInsert(location: Location) {
        self.mapView.addAnnotation(location)
    }
    
    func fetchedResultsChangeDelete(location: Location) {
        self.mapView.removeAnnotation(location)
    }
    
    func fetchedResultsChangeUpdate(location: Location) {
        self.fetchedResultsChangeDelete(location)
        self.fetchedResultsChangeInsert(location)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}