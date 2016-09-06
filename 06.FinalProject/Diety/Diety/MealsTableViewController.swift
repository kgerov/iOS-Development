//
//  MealsTableViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit
import CoreData

class MealsTableViewController : UITableViewController {
    
    let mealTypes = [AppConstants.MealTypes.Breakfast, AppConstants.MealTypes.Brunch,
                     AppConstants.MealTypes.Lunch, AppConstants.MealTypes.Snack,
                     AppConstants.MealTypes.Dinner]
    
    var stack: CoreDataStack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get stack
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.stack = delegate.stack
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
            
            if let mealVC = segue.destinationViewController as? MealsDetailTableViewController {
                
                let indexPath = tableView.indexPathForSelectedRow!
                let mealType = self.mealTypes[indexPath.row]
                
                let fetchRequest = NSFetchRequest(entityName: "Meal")
                
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
                
                let predicate = NSPredicate(format: "type = %@", argumentArray: [mealType])
                fetchRequest.predicate = predicate
                
                let fetchController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: self.stack!.context,
                                                    sectionNameKeyPath: "",
                                                    cacheName: nil)
                
                mealVC.fetchedResultsController = fetchController
            }
        }
    }
    
    func addMeal() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("AddMealViewController")
        self.presentViewController(controller, animated: true, completion: nil)
    }
}