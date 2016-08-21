//
//  FlickrResources.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

extension FlickrClient {
    
    func getCollectionOfPhotos(latitude: Double, longitude: Double) {
        
        let parameters: [String: String!] =
            [Flickr.ParameterKeys.SafeSearch: Flickr.ParameterValues.UseSafeSearch,
             Flickr.ParameterKeys.APIKey: Flickr.ParameterValues.APIKey,
             Flickr.ParameterKeys.Extras: Flickr.ParameterValues.MediumURL,
             Flickr.ParameterKeys.Method: Flickr.ParameterValues.SearchMethod,
             Flickr.ParameterKeys.NoJSONCallback: Flickr.ParameterValues.DisableJSONCallback,
             Flickr.ParameterKeys.Format: Flickr.ParameterValues.ResponseFormat,
             Flickr.ParameterKeys.BoundingBox: bboxString(latitude, longitude: longitude)]
        
        taskForGETMethod("", parameters: parameters, requestValues: [String : String]()) { (result, error) in
            
            
        }
    }
    
    private func bboxString(latitude: Double, longitude: Double) -> String {
        
        let minLon = max(longitude - Flickr.Constants.SearchBBoxHalfWidth, Flickr.Constants.SearchLonRange.0)
        let minLat = max(latitude - Flickr.Constants.SearchBBoxHalfHeight, Flickr.Constants.SearchLatRange.0)
        let maxLon = min(longitude + Flickr.Constants.SearchBBoxHalfWidth, Flickr.Constants.SearchLonRange.1)
        let maxLat = min(latitude + Flickr.Constants.SearchBBoxHalfHeight, Flickr.Constants.SearchLatRange.1)
        
        return "\(minLon),\(minLat),\(maxLon),\(maxLat)"
    }
}