//
//  MapTableViewController.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import UIKit

class MapTableViewController : UITableViewController, DataReloadable {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getStudentLocations()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParseClient.sharedInstance().studentLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PinTableCell") as! PinTableViewCell
        let studentLocation = ParseClient.sharedInstance().studentLocations[indexPath.row]
        
        cell.studentName.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let app = UIApplication.sharedApplication()
        let toOpen = ParseClient.sharedInstance().studentLocations[indexPath.row].mediaUrl
        app.openURL(NSURL(string: toOpen)!)
    }
    
    // MARK: - Helpers
    
    func reloadStudentLocations() {
        
        ParseClient.sharedInstance().downloadStudentLocations(processStudentLocationData)
    }

    
    private func getStudentLocations() {
        
        ParseClient.sharedInstance().getStudentLocations(processStudentLocationData)
    }
    
    private func processStudentLocationData(result: [StudentInformation]?, error: NSError?) {
        
        performUIUpdatesOnMain {
            guard error == nil else {
                NotificationCenter.displayError(self, message: "Failed to get student locations")
                return
            }
            
            guard result != nil else {
                NotificationCenter.displayError(self, message: "No student locations returned")
                return
            }
        
            self.tableView.reloadData()
        }
    }
}
