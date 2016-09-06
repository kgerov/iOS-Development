//
//  MealsTableViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MealsTableViewController : UITableViewController {
    
    let mealTypes = [AppConstants.MealTypes.Breakfast, AppConstants.MealTypes.Brunch,
                     AppConstants.MealTypes.Lunch, AppConstants.MealTypes.Snack,
                     AppConstants.MealTypes.Dinner]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealTypes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mealTypeCell")! as UITableViewCell
        let mealType = self.mealTypes[indexPath.row]
        
        cell.textLabel?.text = mealType
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mealType = self.mealTypes[indexPath.row]
        print(mealType)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier! == "displayMeals" {
            
            if let notesVC = segue.destinationViewController as? MealsDetailTableViewController {
                
                let indexPath = tableView.indexPathForSelectedRow!
                print(self.mealTypes[indexPath.row])
                
//                let fr = NSFetchRequest(entityName: "Note")
//                
//                fr.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false),
//                                      NSSortDescriptor(key: "text", ascending: true)]
//                
//                let notebook = fetchedResultsController?.objectAtIndexPath(indexPath) as? Notebook
//                
//                let pred = NSPredicate(format: "notebook = %@", argumentArray: [notebook!])
//                
//                fr.predicate = pred
//                
//                let fc = NSFetchedResultsController(fetchRequest: fr,
//                                                    managedObjectContext:fetchedResultsController!.managedObjectContext,
//                                                    sectionNameKeyPath: "humanReadableAge",
//                                                    cacheName: nil)
//                
//                notesVC.fetchedResultsController = fc
//                notesVC.notebook = notebook
            }
        }
    }
    
    func addMeal() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("AddMealViewController")
        self.presentViewController(controller, animated: true, completion: nil)
    }
}