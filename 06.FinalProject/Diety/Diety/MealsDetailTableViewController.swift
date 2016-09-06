//
//  MealsDetailTableViewController.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/5/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MealsDetailTableViewController : CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let meal = fetchedResultsController!.objectAtIndexPath(indexPath) as! Meal
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = meal.title
        cell.detailTextLabel?.text = meal.ingridients
        
        return cell
    }
}