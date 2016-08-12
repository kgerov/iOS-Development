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
                    let session = result[Udacity.JSONResponseKeys.Session] as? [String: AnyObject],
                    let id = session[Udacity.JSONResponseKeys.Id] as? String {
                    
                    self.userID = key
                    self.sessionID = id
                    completionHandler(success: true, error: nil)
                } else {
                    completionHandler(success: false, error: NSError(domain: "postSessionId parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse session"]))
                }
            }
        }
    }
}
