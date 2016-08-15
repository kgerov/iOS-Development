//
//  UdacityResources.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/9/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    func getSessionId(username: String, password: String, completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let method: String = Udacity.Methods.Session
        let jsonBody = "{\"\(Udacity.JSONBodyKeys.Udacity)\": {\"\(Udacity.JSONBodyKeys.Username)\": \"\(username)\", \"\(Udacity.JSONBodyKeys.Password)\": \"\(password)\"}}"
        
        taskForPOSTMethod(method, parameters: [String: AnyObject](), jsonBody: jsonBody, requestValues: [String:String]()) { (result, error) in
            
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                if let account = result[Udacity.JSONResponseKeys.Account] as? [String: AnyObject],
                    let key = account[Udacity.JSONResponseKeys.Key] as? String,
                    let isRegistered = account[Udacity.JSONResponseKeys.Registered] as? Bool,
                    let session = result[Udacity.JSONResponseKeys.Session] as? [String: AnyObject],
                    let id = session[Udacity.JSONResponseKeys.Id] as? String {
                    
                    if isRegistered {
                        self.userID = key
                        self.sessionID = id
                        completionHandler(success: true, error: nil)
                    } else {
                        completionHandler(success: false, error: NSError(domain: "userAccount does not exist", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid username or password."]))
                    }
                } else {
                    completionHandler(success: false, error: NSError(domain: "postSessionId parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse session"]))
                }
            }
        }
    }
    
    func deleteSessionId(completionHandler: (success: Bool, error: NSError?) -> Void) {
        
        let method: String = Udacity.Methods.Session
        var values = [String:String]()
        
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            values[xsrfCookie.value] = "X-XSRF-TOKEN"
        }
        
        taskForDELETEMethod(method, parameters: [String : AnyObject](), requestValues: values) { (result, error) in
            
            if let error = error {
                completionHandler(success: false, error: error)
            } else {
                
                self.userID = nil
                self.sessionID = nil
                completionHandler(success: true, error: nil)
            }
        }
    }
    
    func getPublicUserData(completionHandler: (result: StudentAccount?, error: NSError?) -> Void) {
        
        let method: String = subtituteKeyInMethod(Udacity.Methods.UsersId, key: "id", value: self.userID!)!
        
        taskForGETMethod(method, parameters: [String : AnyObject](), requestValues: [String : String]()) { (result, error) in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let result = result[Udacity.JSONResponseKeys.User] as? [String:AnyObject] {
                    
                    let student = StudentAccount(dictionary: result)
                    self.studentAccount = student
                    completionHandler(result: student, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getStudentData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse student data"]))
                }
            }
        }
    }
    
    
}
