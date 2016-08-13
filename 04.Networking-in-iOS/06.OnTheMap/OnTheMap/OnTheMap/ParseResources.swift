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
    
    func isUsersFirstPin(userId: String, completionHandler: (pinId: String?, error: NSError?) -> Void) {
        
        let parameters = [
            Parse.ParameterKeys.Where: "{\"\(Parse.JSONResponseKeys.UniqueKey)\":\"\(userId)\"}"
        ]
        
        let values = [
            Parse.Constants.ApplicationId: Parse.RequestKeys.ApplicationId,
            Parse.Constants.APIKey: Parse.RequestKeys.APIKey
        ]
        
        taskForGETMethod(Parse.Methods.StudentLocation, parameters: parameters, requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(pinId: nil, error: error)
            } else {
                
                if let result = result[Parse.JSONResponseKeys.Results] as? [[String:AnyObject]] {
                
                    let objectId: String? = result.count == 0 ? nil : result[0][Parse.JSONResponseKeys.ObjectId] as? String
                    self.locationId = objectId
                    
                    print(objectId)
                    print(result)
                    
                    completionHandler(pinId: objectId, error: nil)
                } else {
                    completionHandler(pinId: nil, error: NSError(domain: "getStudentPreviousLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse student previous location"]))
                }
            }
        }
    }
    
    func createStudentLocation(key: String, firstName: String, lastName: String, mapString: String, mediaUrl: String, latitude: String, longitude: String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let values = [
            Parse.Constants.ApplicationId: Parse.RequestKeys.ApplicationId,
            Parse.Constants.APIKey: Parse.RequestKeys.APIKey
        ]
        
        let jsonBody = "{\"\(Parse.JSONResponseKeys.UniqueKey)\": \"\(key)\", \"\(Parse.JSONResponseKeys.FirstName)\": \"\(firstName)\", \"\(Parse.JSONResponseKeys.LastName)\": \"\(lastName)\",\"\(Parse.JSONResponseKeys.MapString)\": \"\(mapString)\", \"\(Parse.JSONResponseKeys.MediaURL)\": \"\(mediaUrl)\",\"\(Parse.JSONResponseKeys.Latitude)\": \(latitude), \"\(Parse.JSONResponseKeys.Longitude)\": \(longitude)}"
        
        
        taskForPOSTMethod(Parse.Methods.StudentLocation, parameters: [String : AnyObject](), jsonBody: jsonBody, requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                
                if (result[Parse.JSONResponseKeys.ObjectId] as? String) != nil {
                    
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "postStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse posted student location"]))
                }
            }
        }
    }
    
    func updateStudentLocation(locationId: String, key: String, firstName: String, lastName: String, mapString: String, mediaUrl: String, latitude: String, longitude: String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let method: String = subtituteKeyInMethod(Parse.Methods.StudentLocationId, key: "id", value: locationId)!
        
        let parameters = [String:AnyObject]()
        
        let values = [
            Parse.Constants.ApplicationId: Parse.RequestKeys.ApplicationId,
            Parse.Constants.APIKey: Parse.RequestKeys.APIKey
        ]
        
        let jsonBody = "{\"\(Parse.JSONResponseKeys.UniqueKey)\": \"\(key)\", \"\(Parse.JSONResponseKeys.FirstName)\": \"\(firstName)\", \"\(Parse.JSONResponseKeys.LastName)\": \"\(lastName)\",\"\(Parse.JSONResponseKeys.MapString)\": \"\(mapString)\", \"\(Parse.JSONResponseKeys.MediaURL)\": \"\(mediaUrl)\",\"\(Parse.JSONResponseKeys.Latitude)\": \(latitude), \"\(Parse.JSONResponseKeys.Longitude)\": \(longitude)}"
        
        
        taskForPUTMethod(method, parameters: parameters, jsonBody: jsonBody, requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                
                if (result[Parse.JSONResponseKeys.UpdatedAt] as? String) != nil {
                    
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "postStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse posted student location"]))
                }
            }
        }
    }
}