//
//  BaseClient.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/21/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation

class BaseClient : NSObject {
    
    // MARK: Properties
    
    var session = NSURLSession.sharedSession()
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod(method: String, parameters: [String:AnyObject], requestValues: [String: String], completionHandlerForGET: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: urlFromParameters(parameters, withPathExtension: method))
        
        for (key, value) in requestValues {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        return makeHttpRequest(request, completionHandler: completionHandlerForGET)
    }
    
    // MARK: POST
    
    func taskForPOSTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, requestValues: [String: String], completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: urlFromParameters(parameters, withPathExtension: method))
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in requestValues {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        return makeHttpRequest(request, completionHandler: completionHandlerForPOST)
    }
    
    // MARK: DELETE
    
    func taskForDELETEMethod(method: String, parameters: [String:AnyObject], requestValues: [String: String], completionHandlerForDELETE: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: urlFromParameters(parameters, withPathExtension: method))
        request.HTTPMethod = "DELETE"
        
        for (key, value) in requestValues {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        return makeHttpRequest(request, completionHandler: completionHandlerForDELETE)
    }
    
    // MARK: PUT
    
    func taskForPUTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, requestValues: [String: String], completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: urlFromParameters(parameters, withPathExtension: method))
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in requestValues {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        return makeHttpRequest(request, completionHandler: completionHandlerForPOST)
    }
    
    // MARK: GET Image
    
    func taskForGETImage(url: String, completionHandlerForImage: (imageData: NSData?, error: NSError?) -> Void) -> NSURLSessionTask {
        
        let nsUrl = NSURL(string: url)!
        let request = NSURLRequest(URL: nsUrl)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForImage(imageData: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
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
            
            completionHandlerForImage(imageData: data, error: nil)
        }
        
        task.resume()
        
        return task
    }

    
    // MARK: Helpers
    
    // make HTTP Reques
    internal func makeHttpRequest(request: NSMutableURLRequest, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandler(result: nil, error: NSError(domain: "taskForHttpRequest", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                if error?.code == -1009 {
                    sendError("The Internet connection appears to be offline.")
                } else {
                    sendError("There was an error with your request: \(error)")
                }
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            let statusCode = (response as? NSHTTPURLResponse)?.statusCode
            guard statusCode != nil && statusCode >= 200 && statusCode <= 299 else {
                if statusCode == 403 {
                    sendError("Invalid username or password.")
                } else {
                    sendError("Your request returned a status code other than 2xx! \(response)")
                }
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
    
    internal func initComponents(withPathExtension: String? = nil) -> NSURLComponents {
        let components = NSURLComponents()
        
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
