//
//  KumulosClient.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

class KumulosClient : BaseClient {
    
    // MARK: Helpers
    
    override func initComponents(withPathExtension: String? = nil) -> NSURLComponents {
        let components = NSURLComponents()
        
        components.scheme = Kumulos.Constants.ApiScheme
        components.host = Kumulos.Constants.ApiHost
        components.path = Kumulos.Constants.ApiPath + (withPathExtension ?? "")
        
        return components
    }
    
    // MARK: Shared Instance
    
    override class func sharedInstance() -> KumulosClient {
        struct Singleton {
            static var sharedInstance = KumulosClient()
        }
        
        return Singleton.sharedInstance
    }
}