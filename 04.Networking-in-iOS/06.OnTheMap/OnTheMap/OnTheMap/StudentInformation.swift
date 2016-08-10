//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import MapKit

struct StudentInformation {
    
    let coordinate: CLLocationCoordinate2D
    let firstName: String
    let lastName: String
    let mediaUrl: String
    let uniqueKey: String
    
    init(dictionary: [String:AnyObject]) {
        let lat = CLLocationDegrees(dictionary[BaseClient.Parse.JSONResponseKeys.Latitude] as! Double)
        let long = CLLocationDegrees(dictionary[BaseClient.Parse.JSONResponseKeys.Longitude] as! Double)
        
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        firstName = dictionary[BaseClient.Parse.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[BaseClient.Parse.JSONResponseKeys.LastName] as! String
        mediaUrl = dictionary[BaseClient.Parse.JSONResponseKeys.MediaURL] as! String
        uniqueKey = dictionary[BaseClient.Parse.JSONResponseKeys.UniqueKey] as! String
    }
    
    static func studentLocationsFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var students = [StudentInformation]()
        
        for result in results {
            if result.count < 10 {
                continue
            }
            
            students.append(StudentInformation(dictionary: result))
        }
        
        return students
    }
}