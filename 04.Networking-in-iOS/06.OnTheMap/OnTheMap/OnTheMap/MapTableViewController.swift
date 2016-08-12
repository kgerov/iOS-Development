//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MapTableViewController : UITableViewController {
    
    var studentLocations: [StudentInformation] = ParseClient.sharedInstance().studentLocations
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getStudentLocations()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PinTableCell") as! PinTableViewCell
        let studentLocation = studentLocations[indexPath.row]
        
        cell.studentName.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        
        return cell
    }
    
    private func getStudentLocations() {
        ParseClient.sharedInstance().getStudentLocations() { (result: [StudentInformation]?, error: NSError?) in
            
            guard error == nil else {
                self.displayError("Failed to get student locations")
                return
            }
            
            guard let result = result else {
                self.displayError("No student locations returned")
                return
            }
            
            
            performUIUpdatesOnMain {
                self.studentLocations = result
                self.tableView.reloadData()
            }
        }
    }
    
    func reloadStudentLocations() {
        print("reload from list")
    }
    
    private func displayError(message: String) {
        let alertController = UIAlertController(title: "", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
