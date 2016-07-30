//
//  achievements.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = NSBundle.mainBundle().pathForResource("achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = NSData(contentsOfFile: pathForAchievementsJSON!)

/* Error object */
var parsingAchivementsError: NSError? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAchievementsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    
    guard let categories = dictionary["categories"] as? [[String:AnyObject]] else {
        print("No categories founds in \(dictionary)")
        return
    }
    
    var matchMakingCategories = [Int]()
    
    for category in categories {
        guard let title = category["title"] as? String else {
            print("No title")
            return
        }
        
        if title == "Matchmaking" {
            guard let children = category["children"] as? [[String:AnyObject]] else {
                print("No children founds in \(category)")
                return
            }
            
            for child in children {
                let childId = child["categoryId"] as? Int
                matchMakingCategories.append(childId!)
            }
        }
    }
    
    guard let achievements = dictionary["achievements"] as? [[String:AnyObject]] else {
        print("No achievments founds in \(dictionary)")
        return
    }
    
    var achievementsWithPointsHigherThanTen = 0
    var allAchievementPoints = 0
    var missionForCoolRunning = ""
    var numberOfAchievInMatchmaking = 0
    
    for achievement in achievements {
        if let points = achievement["points"] as? Int {
            if points > 10 {
                achievementsWithPointsHigherThanTen += 1
            }
            
            allAchievementPoints += points
        }
        
        guard let title = achievement["title"] as? String else {
            print("No title")
            return
        }
        
        if title == "Cool Running" {
            let description = achievement["description"] as? String
            missionForCoolRunning = description!
        }
        
        guard let categoryId = achievement["categoryId"] as? Int else {
            print("No category")
            return
        }
        
        if matchMakingCategories.contains(categoryId) {
            numberOfAchievInMatchmaking += 1
        }
    }
    
    print(achievementsWithPointsHigherThanTen)
    print(Double(allAchievementPoints) / Double(achievements.count))
    print(missionForCoolRunning)
    print(numberOfAchievInMatchmaking)
}

parseJSONAsDictionary(parsedAchievementsJSON)
