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
    
    var selectedIndexes = [NSIndexPath]()
    var insertedIndexPaths: [NSIndexPath]!
    var deletedIndexPaths: [NSIndexPath]!
    var updatedIndexPaths: [NSIndexPath]!
    
    private let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noImagesLabel: UILabel!
    @IBOutlet weak var bottomButton: UIBarButtonItem!
    
    // FetchedResultsController
    
    var fetchedResultsController : NSFetchedResultsController?{
        didSet {
            fetchedResultsController?.delegate = self
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
        
        self.executeSearch()
        
        // Add annotation to map and zoom to annotation
        if location != nil {
            self.mapView.addAnnotation(location!)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
        
        self.updateNoImagesLabel()
        setupFlowLayout(view.frame.size)
    }
    
    // MARK: - Actions
    
    @IBAction func bottomButtonPressed(sender: AnyObject) {
        
        if self.bottomButton.title ==  "New Collection" {
            self.getCollectionFromFlickr()
        } else {
            self.deleteSelectedPhotos()
        }
    }
    
    // MARK: - Configure Cell
    
    func configureCell(cell: PhotoCollectionViewCell, atIndexPath indexPath: NSIndexPath) {
        
        cell.activityIndicator.stopAnimating()
        
        let photo = self.fetchedResultsController!.objectAtIndexPath(indexPath) as! Photo
        var cellImage = UIImage(named: "placeholder")
        cell.imageView.image = nil
        
        if photo.imageData == nil {
            
            cell.activityIndicator.startAnimating()
            
            let task = FlickrClient.sharedInstance().taskForGETImage(photo.url!) { (imageData, error) in
                
                func displayError(message: String) {
                    cell.activityIndicator.stopAnimating()
                    let alertController = UIAlertController(title: nil, message:
                        message, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
                guard error == nil else {
                    displayError("Failed to get image from url")
                    return
                }
                
                guard let imageData = imageData else {
                    displayError("No image  returned")
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    photo.imageData = imageData
                    cell.imageView.image = UIImage(data: imageData)
                    cell.activityIndicator.stopAnimating()
                }
            }
            
            
        } else {
            cellImage = UIImage(data: photo.imageData!)
        }
        
        cell.imageView.image = cellImage
        
        if selectedIndexes.indexOf(indexPath) != nil {
            cell.alpha = 0.5
        } else {
            cell.alpha = 1.0
        }
    }
    
    // MARK: - UICollectionView Methods
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCollectionViewCell", forIndexPath: indexPath)
                as! PhotoCollectionViewCell
            
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
            
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCollectionViewCell
        
        if let index = selectedIndexes.indexOf(indexPath) {
            selectedIndexes.removeAtIndex(index)
        } else {
            selectedIndexes.append(indexPath)
        }
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        updateBottonToolbarText()
    }
    
    // MARK: - Helpers
    
    func deleteSelectedPhotos() {
        
        var photos = [Photo]()
        
        for indexPath in selectedIndexes {
            photos.append(fetchedResultsController!.objectAtIndexPath(indexPath) as! Photo)
        }
        
        for photo in photos {
            self.fetchedResultsController?.managedObjectContext.deleteObject(photo)
        }
        
        self.appDelegate.stack.save()
        selectedIndexes = [NSIndexPath]()
    }
    
    func getCollectionFromFlickr() {
        
        for photo in self.fetchedResultsController!.fetchedObjects as! [Photo] {
            self.fetchedResultsController!.managedObjectContext.deleteObject(photo)
        }
        
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
            
            self.appDelegate.stack.performBackgroundBatchOperation { (workerContext) in
                for url in result {
                    
                    let photo = Photo(url: url, context: workerContext)
                    let contextLocation = workerContext.objectWithID(self.location.objectID) as? Location
                    photo.location = contextLocation
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue()) {
                self.collectionView.reloadData()
            }
        }
    }
    
    func updateBottonToolbarText() {
        
        if self.selectedIndexes.count > 0 {
            self.bottomButton.title = "Remove Selected Photos"
        } else {
            self.bottomButton.title = "New Collection"
        }
    }
    
    func updateNoImagesLabel() {
        
        if self.location.photos?.count > 0 {
            self.noImagesLabel.hidden = true
        } else {
            self.noImagesLabel.hidden = false
        }
    }
    
    // transitions
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setupFlowLayout(size)
    }
    
    func setupFlowLayout(size: CGSize) {
        let space: CGFloat = 1.0
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
}

// MARK:  - Collection Data Source
extension LocationCollectionViewController {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController!.sections?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController!.sections![section]
        
        return sectionInfo.numberOfObjects
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
        insertedIndexPaths = [NSIndexPath]()
        deletedIndexPaths = [NSIndexPath]()
        updatedIndexPaths = [NSIndexPath]()
    }
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        switch type {
            case .Insert:
                insertedIndexPaths.append(newIndexPath!)
                break
            case .Delete:
                deletedIndexPaths.append(indexPath!)
                break
            case .Update:
                updatedIndexPaths.append(indexPath!)
                break
            case .Move:
                break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        collectionView.performBatchUpdates({() -> Void in
            
            for indexPath in self.insertedIndexPaths {
                self.collectionView.insertItemsAtIndexPaths([indexPath])
            }
            
            for indexPath in self.deletedIndexPaths {
                self.collectionView.deleteItemsAtIndexPaths([indexPath])
            }
            
            for indexPath in self.updatedIndexPaths {
                self.collectionView.reloadItemsAtIndexPaths([indexPath])
            }
            
            }, completion: nil)
    }
}