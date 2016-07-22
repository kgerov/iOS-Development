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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = applicationDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath)
        let meme = memes[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}
