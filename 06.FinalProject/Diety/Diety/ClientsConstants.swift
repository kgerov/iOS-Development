//
//  ClientsConstants.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

extension BaseClient {
    
    struct Kinvey {
        
        struct Constants {
            static let ApiScheme = "https"
            static let ApiHost = "baas.kinvey.com"
            static let ApiPath = ""
            
            static let AppId = "kid_S1ew1tcj"
            static let AppSecret = "b38e4456b9ae4db5ad3d6b22527c46d1"
            static let AppMasterSecret = "9a9cbec2c51d436f82a4815850da7c6c"
        }
        
        struct Methods {
            static let LoginUser = "/user/" + Constants.AppId + "/login"
            static let RegisterUser = "/user/" + Constants.AppId
            static let LogoutUser = "/user/" + Constants.AppId + "/_logout"
            static let mealByType = "/appdata/" + Constants.AppId + "/meals/?query={\"type\":\"{type}\"}"
            static let allMeals = "/appdata/" + Constants.AppId + "/meals"
        }
        
        // MARK: Kumulos Parameter Keys
        struct ParameterKeys {
            static let Username = "username"
            static let Password = "password"
        }
        
        // MARK: Kumulos Parameter Values
        struct ParameterValues {
            
        }
        
        // MARK: Kumulos Parameter Values
        struct JSONResponseKeys {
            static let KMD = "_kmd"
            static let AuthToken = "authtoken"
        }
    }
}
