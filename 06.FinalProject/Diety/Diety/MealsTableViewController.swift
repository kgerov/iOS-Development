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
}