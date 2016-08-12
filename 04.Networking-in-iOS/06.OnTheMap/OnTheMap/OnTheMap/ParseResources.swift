//
//  ParseResources.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

extension ParseClient {

    func getStudentLocations(completionHandler: (result: [StudentInformation]?, error: NSError?) -> Void) {
        if self.studentLocations.count == 0 {
            downloadStudentLocations(completionHandler)
        } else {
            completionHandler(result: self.studentLocations, error: nil)
        }
    }
    
    func downloadStudentLocations(completionHandler: (result: [StudentInformation]?, error: NSError?) -> Void) {
        
        let parameters = [
            Parse.ParameterKeys.Limit: Parse.ParameterValues.NumberOfStudentLocations,
            Parse.ParameterKeys.Order: Parse.ParameterValues.OrderByDate
        ]
        
        let values = [
            Parse.Constants.ApplicationId: Parse.RequestKeys.ApplicationId,
            Parse.Constants.APIKey: Parse.RequestKeys.APIKey
        ]
        
        taskForGETMethod(Parse.Methods.StudentLocation, parameters: parameters, requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let results = result[Parse.JSONResponseKeys.Results] as? [[String:AnyObject]] {
                    
                    let studentLocations = StudentInformation.studentLocationsFromResults(results)
                    completionHandler(result: studentLocations, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse student locations"]))
                }
            }
        }
    }
}