//
//  NoteTableViewController.swift
//  CoolNotes
//
//  Created by Konstantin Gerov on 8/18/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewController : CoreDataTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let note = fetchedResultsController!.objectAtIndexPath(indexPath) as? Note
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = note?.text
        
        return cell
    }
}