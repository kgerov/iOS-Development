//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/10/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

class ParseClient : BaseClient {
    
    var studentLocations = [StudentInformation]()
    
    // MARK: Helpers
    
    override func initComponents(withPathExtension: String? = nil) -> NSURLComponents {
        let components = NSURLComponents()
        
        components.scheme = Parse.Constants.ApiScheme
        components.host = Parse.Constants.ApiHost
        components.path = Parse.Constants.ApiPath + (withPathExtension ?? "")
        
        return components
    }
    
    override func insertValuesInUrl(request: NSMutableURLRequest) {
        request.addValue(Parse.Constants.ApplicationId, forHTTPHeaderField: Parse.RequestKeys.ApplicationId)
        request.addValue(Parse.Constants.APIKey, forHTTPHeaderField: Parse.RequestKeys.APIKey)
    }
    
    // MARK: Shared Instance
    
    override class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        
        return Singleton.sharedInstance
    }
}