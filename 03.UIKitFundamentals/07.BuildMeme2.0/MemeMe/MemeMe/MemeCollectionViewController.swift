//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Konstantin Gerov on 7/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController {

    var memes: [Meme]!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlowLayout(view.frame.size)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = applicationDelegate.memes
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath)
            as! MemeCollectionViewCell
            
        let meme = memes[indexPath.row]
            
        cell.memeImage.image = meme.originalImage
        cell.addText(meme.topText, bottomText: meme.bottomText)
            
        return cell

    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
        
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.minimumLineSpacing = space
        flowLayout?.itemSize = CGSizeMake(dimension, dimension)
    }
}
