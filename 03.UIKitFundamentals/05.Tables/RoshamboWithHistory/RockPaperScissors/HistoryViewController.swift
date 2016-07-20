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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let placeholderCount = self.history.count
        return placeholderCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)!
        cell.textLabel?.text = history[indexPath.row].loser.description
        return cell
    }
}
