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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "displayNote"{
            
            if let notesVC = segue.destinationViewController as? NoteTableViewController{
                
                // Create Fetch Request
                let fetchRequest = NSFetchRequest(entityName: "Note")
                
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false),
                                      NSSortDescriptor(key: "text", ascending: true)]
                
                // So far we have a search that will match ALL notes. However, we're
                // only interested in those within the current notebook:
                // NSPredicate to the rescue!
                let indexPath = tableView.indexPathForSelectedRow!
                let notebook = fetchedResultsController?.objectAtIndexPath(indexPath)
                
                let notebookPredicate = NSPredicate(format: "notebook = %@", argumentArray: [notebook!])
                
                fetchRequest.predicate = notebookPredicate
                
                // Create FetchedResultsController
                let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext:fetchedResultsController!.managedObjectContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
                
                // Inject it into the notesVC
                notesVC.fetchedResultsController = fetchController
                notesVC.title = (notebook as? Notebook)?.name
            }
        }
    }
}
