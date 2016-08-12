//
//  StudentAccount.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/12/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

struct StudentAccount {
    
    let firstName: String
    let lastName: String
    
    init(dictionary: [String:AnyObject]) {
        
        firstName = dictionary[BaseClient.Udacity.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[BaseClient.Udacity.JSONResponseKeys.LastName] as! String
    }
}
