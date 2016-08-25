//
//  LocationCollectionViewController.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class LocationCollectionViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var location: Location! = nil
    var blockOperations: [NSBlockOperation] = []
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noImagesLabel: UILabel!
    
    // FetchedResultsController
    
    var fetchedResultsController : NSFetchedResultsController?{
        didSet {
            fetchedResultsController?.delegate = self
            self.reloadImagesInCollection()
        }
    }
    
    init(fetchedResultsController fc : NSFetchedResultsController) {
        
        fetchedResultsController = fc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        if location.hasBeenOpened == false {
            location.hasBeenOpened = true
            self.getCollectionFromFlickr()
        }
        
        self.reloadImagesInCollection()

        // Add annotation to map and zoom to annotation
        if location != nil {
            self.mapView.addAnnotation(location!)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func getNewCollection(sender: AnyObject) {
        self.getCollectionFromFlickr()
    }
    
    // MARK: - UICollectionView Methods
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCollectionViewCell", forIndexPath: indexPath)
                as! PhotoCollectionViewCell
            
            let photo = fetchedResultsController!.objectAtIndexPath(indexPath) as! Photo
            
            if let photoUrl = photo.url,
                let imageUrl = NSURL(string: photoUrl),
                let imageData = NSData(contentsOfURL: imageUrl) {
                
                cell.imageView.image = UIImage(data: imageData)
            } else {
                cell.imageView.image = UIImage()
            }
            
        
        return cell
            
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    // MARK: - Helpers
    
    func getCollectionFromFlickr() {
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let stack = delegate.stack
        
        stack.save()
        
        stack.performBackgroundBatchOperation { (workerContext) in
            
            FlickrClient.sharedInstance().getCollectionOfPhotos(Double(self.location.latitude!), longitude: Double(self.location.longitude!)) { (result, error) in
                
                func displayError(message: String) {
                    let alertController = UIAlertController(title: nil, message:
                        message, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
                guard error == nil else {
                    displayError("Failed to get student locations")
                    return
                }
                
                guard let result = result else {
                    displayError("No student locations returned")
                    return
                }
                
                for url in result {
                    
                    let photo = Photo(url: url, context: workerContext)
                    let contextLocation = workerContext.objectWithID(self.location.objectID) as? Location
                    photo.location = contextLocation
                }
            }
        }
    }
    
    func reloadImagesInCollection() {
        executeSearch()
        
        if self.collectionView != nil {
            self.collectionView.reloadData()
        }
    }
    
    // transitions
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setupFlowLayout(size)
    }
    
    func setupFlowLayout(size: CGSize) {
        let space: CGFloat = 3.0
        var dimension: CGFloat
        
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            dimension = (size.width - (4 * space)) / 5.0
        } else {
            dimension = (size.width - (2 * space)) / 3.0
        }
        
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.minimumLineSpacing = space
        flowLayout?.itemSize = CGSizeMake(dimension, dimension)
    }
    
    deinit {
        for operation: NSBlockOperation in blockOperations {
            operation.cancel()
        }
        
        blockOperations.removeAll(keepCapacity: false)
    }
}

// MARK:  - Collection Data Source
extension LocationCollectionViewController {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let fc = fetchedResultsController {
            return (fc.sections?.count)!;
        }else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let fc = fetchedResultsController {
            return fc.sections![section].numberOfObjects;
        }else{
            return 0
        }
    }
}

// MARK:  - Fetches
extension LocationCollectionViewController {
    
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
extension LocationCollectionViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        blockOperations.removeAll(keepCapacity: false)
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                                     atIndex sectionIndex: Int,
                                             forChangeType type: NSFetchedResultsChangeType) {
        
        switch (type){
            
        case .Insert:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.insertSections(NSIndexSet(index: sectionIndex))
                    }
                })
            )
            
        case .Update:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadSections(NSIndexSet(index: sectionIndex))
                    }
                    })
            )
            
        case .Delete:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteSections(NSIndexSet(index: sectionIndex))
                    }
                })
            )
            
        default:
            // irrelevant in our case
            break
            
        }
    }
    
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        
        
        switch(type){
            
        case .Insert:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadItemsAtIndexPaths([indexPath!])
                    }
                })
            )
            
        case .Delete:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.deleteItemsAtIndexPaths([indexPath!])
                    }
                })
            )
            
        case .Update:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.reloadItemsAtIndexPaths([indexPath!])
                    }
                })
            )
            
        case .Move:
            blockOperations.append(
                NSBlockOperation(block: { [weak self] in
                    if let this = self {
                        this.collectionView!.moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
                    }
                })
            )
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView!.performBatchUpdates({ () -> Void in
            for operation: NSBlockOperation in self.blockOperations {
                operation.start()
            }
            }, completion: { (finished) -> Void in
                self.blockOperations.removeAll(keepCapacity: false)
        })
    }
}