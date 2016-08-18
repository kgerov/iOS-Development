//
//  NotebooksTableViewController.swift
//  CoolNotes
//
//  Created by Konstantin Gerov on 8/18/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import CoreData
class NotebooksTableViewController : CoreDataTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cool Notes"
        
        // Get the stack
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let stack = delegate?.stack
        
        // Create a fetchrequest
        let fetchRequest = NSFetchRequest(entityName: "Notebook")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true),
            NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create fetch result controller
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: (stack?.context)!, sectionNameKeyPath: nil, cacheName: nil)
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let notebook = fetchedResultsController!.objectAtIndexPath(indexPath) as? Notebook
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NotebookCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = notebook?.name
        cell.detailTextLabel?.text = "\(Int((notebook?.notes?.count)!)) notes"
        
        return cell
    }
}
