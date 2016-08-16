//
//  StudentManager.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/16/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

class StudentManager {
    
    var studentLocations = [StudentInformation]()
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> StudentManager {
        struct Singleton {
            static var sharedInstance = StudentManager()
        }
        
        return Singleton.sharedInstance
    }
}
