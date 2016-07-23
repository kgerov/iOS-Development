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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = applicationDelegate.memes
        tableView.reloadData()
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
}
