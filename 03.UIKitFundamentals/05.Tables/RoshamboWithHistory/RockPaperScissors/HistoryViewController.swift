//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by Konstantin Gerov on 7/20/16.
//  Copyright © 2016 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let cellReuseIdentifier = "RoshamboMatchCell"
    var history = [RPSMatch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func homeButtonPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let placeholderCount = self.history.count
        return placeholderCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)!
        var resultText = ""
        if (history[indexPath.row].winner == history[indexPath.row].p1 &&
            history[indexPath.row].winner == history[indexPath.row].p2) {
            
            resultText = "Tie"
        } else if (history[indexPath.row].winner == history[indexPath.row].p1) {
            resultText = "Win!"
        } else {
            resultText = "Loss."
        }
        
        let detailText = history[indexPath.row].p1.description +
            " vs. " +
            history[indexPath.row].p2.description
        
        cell.textLabel?.text = resultText
        cell.detailTextLabel?.text = detailText
        return cell
    }
}
