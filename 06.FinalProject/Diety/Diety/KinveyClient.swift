//
//  KinveyClient.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

class KinveyClient : BaseClient {
    
    var authToken: String? = nil
    
    // MARK: Helpers
    override func initComponents(withPathExtension: String? = nil) -> NSURLComponents {
        let components = NSURLComponents()
        
        components.scheme = Kinvey.Constants.ApiScheme
        components.host = Kinvey.Constants.ApiHost
        components.path = Kinvey.Constants.ApiPath + (withPathExtension ?? "")
        
        return components
    }
    
    // MARK: Shared Instance
    
    override class func sharedInstance() -> KinveyClient {
        struct Singleton {
            static var sharedInstance = KinveyClient()
        }
        
        return Singleton.sharedInstance
    }
}