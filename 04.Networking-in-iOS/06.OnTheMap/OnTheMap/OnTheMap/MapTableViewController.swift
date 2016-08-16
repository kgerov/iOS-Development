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
        return StudentManager.sharedInstance().studentLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PinTableCell") as! PinTableViewCell
        let studentLocation = StudentManager.sharedInstance().studentLocations[indexPath.row]
        
        cell.studentName.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let app = UIApplication.sharedApplication()
        let toOpen = StudentManager.sharedInstance().studentLocations[indexPath.row].mediaUrl
        
        if verifyUrl(toOpen) {
            app.openURL(NSURL(string: toOpen)!)
        } else {
            NotificationCenter.displayError(self, message: "Invalid URL")
        }
    }
    
    // MARK: - Helpers
    
    func reloadStudentLocations() {
        
        ParseClient.sharedInstance().downloadStudentLocations(processStudentLocationData)
    }

    
    private func verifyUrl (urlString: String?) -> Bool {
        
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        
        return false
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
