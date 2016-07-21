//
//  VillianCollectionViewContoller.swift
//  BondVillains
//
//  Created by Konstantin Gerov on 7/21/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class VillianCollectionViewContoller : UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    let allVillains = Villain.allVillains
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout(view.frame.size)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allVillains.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomVillainCell", forIndexPath: indexPath) as! CustomVillainCell
        let villain = allVillains[indexPath.item]
        
        cell.imageView?.image = UIImage(named: villain.imageName)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC =
            self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController")
            as! VillainDetailViewController
        
        detailVC.villain = self.allVillains[indexPath.row]
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
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
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
}
