//
//  ResultViewController.swift
//  Roshambo
//
//  Created by Konstantin Gerov on 6/26/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var userChoice: Roshambo?
    var computerChoice: Roshambo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userChoice)
        print(computerChoice)
    }
}
