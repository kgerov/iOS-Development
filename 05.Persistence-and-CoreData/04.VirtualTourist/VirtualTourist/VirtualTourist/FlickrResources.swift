//
//  FlickrResources.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

extension FlickrClient {
    
    func getCollectionOfPhotos(latitude: Double, longitude: Double, completionHandler: (result: [String]?, error: NSError?) -> Void) {
        
        let parameters: [String: String!] =
            [Flickr.ParameterKeys.SafeSearch: Flickr.ParameterValues.UseSafeSearch,
             Flickr.ParameterKeys.APIKey: Flickr.ParameterValues.APIKey,
             Flickr.ParameterKeys.Extras: Flickr.ParameterValues.MediumURL,
             Flickr.ParameterKeys.Method: Flickr.ParameterValues.SearchMethod,
             Flickr.ParameterKeys.NoJSONCallback: Flickr.ParameterValues.DisableJSONCallback,
             Flickr.ParameterKeys.Format: Flickr.ParameterValues.ResponseFormat,
             Flickr.ParameterKeys.PerPage: Flickr.ParameterValues.PerPageValue,
             Flickr.ParameterKeys.BoundingBox: bboxString(latitude, longitude: longitude)]
        
        taskForGETMethod("", parameters: parameters, requestValues: [String : String]()) { (result, error) in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                guard let photos = result[Flickr.JSONResponseKeys.Photos] as? [String: AnyObject] else {
                    
                    print("Cannont find key '\(Flickr.JSONResponseKeys.Photos)' in \(result)")
                    return
                }
                
                guard let numberOfPages = photos[Flickr.JSONResponseKeys.Pages] as? Int else {
                    
                    print("Cannont find key '\(Flickr.JSONResponseKeys.Pages)'")
                    return
                }
                
                let pageLimit = min(numberOfPages, Flickr.Constants.maxNumberOfPages)
                let randomPage = Int(arc4random_uniform(UInt32(pageLimit))) + 1

                self.getCollectionOfPhotos(latitude, longitude: longitude, pageNumber: randomPage, completionHandler: completionHandler)
            }
        }
    }
    
    func getCollectionOfPhotos(latitude: Double, longitude: Double, pageNumber: Int, completionHandler: (result: [String]?, error: NSError?) -> Void) {
        
        let parameters: [String: String!] =
            [Flickr.ParameterKeys.SafeSearch: Flickr.ParameterValues.UseSafeSearch,
             Flickr.ParameterKeys.APIKey: Flickr.ParameterValues.APIKey,
             Flickr.ParameterKeys.Extras: Flickr.ParameterValues.MediumURL,
             Flickr.ParameterKeys.Method: Flickr.ParameterValues.SearchMethod,
             Flickr.ParameterKeys.NoJSONCallback: Flickr.ParameterValues.DisableJSONCallback,
             Flickr.ParameterKeys.Format: Flickr.ParameterValues.ResponseFormat,
             Flickr.ParameterKeys.PerPage: Flickr.ParameterValues.PerPageValue,
             Flickr.ParameterKeys.Page: String(pageNumber),
             Flickr.ParameterKeys.BoundingBox: bboxString(latitude, longitude: longitude)]
        
        taskForGETMethod("", parameters: parameters, requestValues: [String : String]()) { (result, error) in
            
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let results = result[Flickr.JSONResponseKeys.Photos] as? [String:AnyObject],
                    let photos = results[Flickr.JSONResponseKeys.Photo] as? [[String:AnyObject]] {
                    
                    var photoUrls = [String]()
                    
                    for photo in photos {
                        
                        if let url = photo[Flickr.JSONResponseKeys.MediumURL] as? String {
                            photoUrls.append(url)
                        }
                    }
                    
                    completionHandler(result: photoUrls, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse photos"]))
                }
            }
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