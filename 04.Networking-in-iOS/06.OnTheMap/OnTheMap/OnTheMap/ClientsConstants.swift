//
//  ClientsConstants.swift
//  OnTheMap
//
//  Created by Konstantin Gerov on 8/9/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

extension BaseClient {

    struct Udacity {
        
        struct Constants {
            static let ApiScheme = "https"
            static let ApiHost = "udacity.com"
            static let ApiPath = "/api"
        }
        
        struct Methods {
            static let Session = "/session"
        }
        
        struct JSONBodyKeys {
            static let Udacity = "udacity"
            static let Username = "username"
            static let Password = "password"
        }
        
        struct JSONResponseKeys {
            static let Account = "account"
            static let Key = "key"
            static let Session = "session"
            static let Id = "id"
        }
    }
    
    struct Parse {
        
        struct Constants {
            static let ApiScheme = "https"
            static let ApiHost = "parse.udacity.com"
            static let ApiPath = "/parse"
        }
    }
}
