//
//  PlayViewController.swift
//  Roshambo
//
//  Created by Konstantin Gerov on 6/26/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Segue - Scissors
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! ResultViewController
        let userChoice = sender as! UIButton
        
        initiateResultController(controller, userChoice: Roshambo(rawValue: userChoice.tag)!)
    }
    
    // Code and Segue - Paper
    @IBAction func showResultOfMatchWithSegue(sender: UIButton?) {
        performSegueWithIdentifier("ShowResult", sender: sender)
    }
    
    // Only code - Rock
    @IBAction func showResultOfMatch() {
        var controller: ResultViewController
        
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        
        initiateResultController(controller, userChoice: Roshambo.Rock)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    private func initiateResultController(controller: ResultViewController, userChoice: Roshambo) {
        controller.userChoice = userChoice
        controller.computerChoice = getComputerChoice()
    }
    
    private func getComputerChoice() -> Roshambo {
        let randomValue = 1 + arc4random() % 6
        
        return Roshambo(rawValue: Int(randomValue))!
    }
}

