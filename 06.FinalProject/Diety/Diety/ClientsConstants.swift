//
//  ClientsConstants.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

extension BaseClient {
    
    struct Kumulos {
        
        struct Constants {
            static let ApiScheme = "https"
            static let ApiHost = "api.flickr.com"
            static let ApiPath = "/services/rest"
        }
        
        // MARK: Kumulos Parameter Keys
        struct ParameterKeys {
            static let Method = "method"
            static let APIKey = "api_key"
            static let GalleryID = "gallery_id"
        }
        
        // MARK: Kumulos Parameter Values
        struct ParameterValues {
            static let SearchMethod = "flickr.photos.search"
            static let APIKey = "4ee61635b36c45193563ca374f9ab284" // PUT NEW API KEY
        }
        
        // MARK: Kumulos Parameter Values
        struct JSONResponseKeys {
            static let Status = "stat"
            static let Photos = "photos"
        }
    }
}
