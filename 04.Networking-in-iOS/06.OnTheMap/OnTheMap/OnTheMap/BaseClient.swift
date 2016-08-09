//
//  BaseClient.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/9/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

class BaseClient : NSObject {
    
    // MARK: Properties
    
    var session = NSURLSession.sharedSession()
    var sessionID: String? = nil
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod(method: String, parameters: [String:AnyObject], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Set the parameters */
        var parametersWithApiKey = parameters
        //parametersWithApiKey[ParameterKeys.ApiKey] = Constants.ApiKey
        
        /* Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: urlFromParameters(parametersWithApiKey, withPathExtension: method))
        
        return makeHttpRequest(request, completionHandler: completionHandlerForGET)
    }
    
    // MARK: POST
    
    func taskForPOSTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Set the parameters */
        var parametersWithApiKey = parameters
        //parametersWithApiKey[ParameterKeys.ApiKey] = Constants.ApiKey
        
        /* Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: urlFromParameters(parametersWithApiKey, withPathExtension: method))
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        return makeHttpRequest(request, completionHandler: completionHandlerForPOST)
    }
    
    // MARK: Helpers
    
    // make HTTP Reques
    internal func makeHttpRequest(request: NSMutableURLRequest, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandler(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandler)
        }
        
        /* Start the request */
        task.resume()
        
        return task
    }
    
    // substitute the key for the value that is contained within the method name
    func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    // given raw JSON, return a usable Foundation object
    internal func convertDataWithCompletionHandler(data: NSData, completionHandlerForConvertData: (result: AnyObject!, error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(result: nil, error: NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(result: parsedResult, error: nil)
    }
    
    // create a URL from parameters
    private func urlFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
        
        let components = initComponents(withPathExtension)
        
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
    
    private func initComponents(withPathExtension: String? = nil) -> NSURLComponents {
        let components = NSURLComponents()
        
        //components.scheme = TMDBClient.Constants.ApiScheme
        //components.host = TMDBClient.Constants.ApiHost
        //components.path = TMDBClient.Constants.ApiPath + (withPathExtension ?? "")
        
        return components
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> BaseClient {
        struct Singleton {
            static var sharedInstance = BaseClient()
        }
        
        return Singleton.sharedInstance
    }
}