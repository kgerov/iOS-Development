//
//  FlickrClient.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

class FlickrClient : BaseClient {
    
    // MARK: Helpers
    
    override func initComponents(withPathExtension: String? = nil) -> NSURLComponents {
        let components = NSURLComponents()
        
        components.scheme = Flickr.Constants.ApiScheme
        components.host = Flickr.Constants.ApiHost
        components.path = Flickr.Constants.ApiPath + (withPathExtension ?? "")
        
        return components
    }
    
    // MARK: Shared Instance
    
    override class func sharedInstance() -> FlickrClient {
        struct Singleton {
            static var sharedInstance = FlickrClient()
        }
        
        return Singleton.sharedInstance
    }
}
