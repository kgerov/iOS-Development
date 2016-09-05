//
//  KinveyResources.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

extension KinveyClient {
    
    func login(username: String, password: String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let method: String = Kinvey.Methods.LoginUser
        
        let parameters = [String:AnyObject]()
        
        let jsonBody = "{\"\(Kinvey.ParameterKeys.Username)\": \"\(username)\", \"\(Kinvey.ParameterKeys.Password)\": \"\(password)\"}"
        
        let loginString = NSString(format: "%@:%@", Kinvey.Constants.AppId, Kinvey.Constants.AppSecret)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        let values = [
            "Basic \(base64LoginString)": "Authorization"
        ]
        
        taskForPOSTMethod(method, parameters: parameters, jsonBody: jsonBody, requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                
                if let kmd = result[Kinvey.JSONResponseKeys.KMD] as? [String:AnyObject],
                    let authtoken = kmd[Kinvey.JSONResponseKeys.AuthToken] as? String {
                    
                    self.authToken = authtoken
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "loginUser parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse login response"]))
                }
            }
        }
    }
    
    func register(username: String, password: String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let method: String = Kinvey.Methods.RegisterUser
        
        let parameters = [String:AnyObject]()
        
        let jsonBody = "{\"\(Kinvey.ParameterKeys.Username)\": \"\(username)\", \"\(Kinvey.ParameterKeys.Password)\": \"\(password)\"}"
        
        let loginString = NSString(format: "%@:%@", Kinvey.Constants.AppId, Kinvey.Constants.AppSecret)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        let values = [
            "Basic \(base64LoginString)": "Authorization"
        ]
        
        taskForPOSTMethod(method, parameters: parameters, jsonBody: jsonBody, requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                
                if (result[Kinvey.ParameterKeys.Username] as? String) != nil {
                    
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "loginUser parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse login response"]))
                }
            }
        }
    }
    
    func logout(completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let method: String = Kinvey.Methods.LogoutUser

        let parameters = [String:AnyObject]()

        let values = [
            "Kinvey \(self.authToken!)": "Authorization"
        ]

        taskForPOSTMethod(method, parameters: parameters, jsonBody: "", requestValues: values) { (result, error) in
            
            if let error = error where error.domain != "convertDataWithCompletionHandler" {
                completionHandler(success: false, error: error)
            } else {
                completionHandler(success: true, error: nil)
            }
        }
    }
    
//    func getMealsByType(type: String, completionHandler: (meals: [Meal]?, error: NSError?) -> Void) {
//        
//        let method: String = subtituteKeyInMethod(Kinvey.Methods.mealByType, key: "type", value: type)!
//        
//        let parameters = [String:AnyObject]()
//        
//        let values = [
//            "Kinvey \(self.authToken)": "Authorization"
//        ]
//        
//        taskForGETMethod(method, parameters: parameters, requestValues: values) { (result, error) in
//            
//            if let error = error {
//                completionHandler(meals: nil, error: error)
//            } else {
//                
//                if let kmd = result[Kinvey.JSONResponseKeys.KMD] as? [String:AnyObject],
//                    let authtoken = kmd[Kinvey.JSONResponseKeys.AuthToken] as? String {
//                    
//                    //completionHandler(meals: meals, error: nil)
//                } else {
//                    completionHandler(meals: nil, error: NSError(domain: "loginUser parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse login response"]))
//                }
//            }
//        }
//    }
    
    
}