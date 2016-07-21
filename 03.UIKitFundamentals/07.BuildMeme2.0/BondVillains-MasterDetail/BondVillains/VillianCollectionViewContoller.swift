//
//  VillianCollectionViewContoller.swift
//  BondVillains
//
//  Created by Konstantin Gerov on 7/21/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class VillianCollectionViewContoller : UICollectionViewController {
    
    let allVillains = Villain.allVillains
    
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
}
