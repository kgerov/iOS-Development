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
            static let UsersId = "/users/{id}"
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
            static let ApplicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
            static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
            
            static let ApiScheme = "https"
            static let ApiHost = "parse.udacity.com"
            static let ApiPath = "/parse/classes"
        }
        
        struct Methods {
            static let StudentLocation = "/StudentLocation"
            static let StudentLocationId = "/StudentLocation/{id}"
        }
        
        struct ParameterKeys {
            static let Limit = "limit"
            static let Skip = "Skip"
            static let Order = "order"
        }
        
        struct ParameterValues {
            static let NumberOfStudentLocations = "100"
            static let OrderByDate = "-updatedAt"
        }
        
        struct JSONResponseKeys {
            static let FirstName = "firstName"
            static let LastName = "lastName"
            static let Latitude = "latitude"
            static let Longitude = "longitude"
            static let MediaURL = "mediaURL"
            static let UniqueKey = "uniqueKey"
            static let Results = "results"
        }
        
        struct RequestKeys {
            static let ApplicationId = "X-Parse-Application-Id"
            static let APIKey = "X-Parse-REST-API-Key"
        }
    }
}
