//
//  DetailController.swift
//  BondVillains
//
//  Created by Konstantin Gerov on 7/21/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class DetailController : UIViewController {
    
    var villain: Villain!
    
    @IBOutlet weak var villianImage: UIImageView!
    @IBOutlet weak var villianName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        villianName.text = villain.name
        villianImage.image = UIImage(named: villain.imageName)
    }
}
