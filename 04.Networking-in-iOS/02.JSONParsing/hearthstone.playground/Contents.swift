//
//  hearthstone.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = NSBundle.mainBundle().pathForResource("hearthstone", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = NSData(contentsOfFile: pathForHearthstoneJSON!)

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! NSJSONSerialization.JSONObjectWithData(rawHearthstoneJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    guard let basics = dictionary["Basic"] as? [[String:AnyObject]] else {
        print("No objects in \(dictionary)")
        return
    }
    
    var minionsWithACostOfFive = 0
    var weaponsWithDurabilityTwo = 0
    var minionsWithBattleCryEffect = 0
    var sumCostOfCommonMinions = 0
    var numberOfCommonMinions = 0
    var statsToCostRatioSum = 0.0
    var notFreeMinions = 0
    
    for basic in basics {
        guard let type = basic["type"] as? String else {
            print("No type in \(basic)")
            return
        }
        
        if type == "Minion" {
            guard let cost = basic["cost"] as? Int else {
                print("No cost in \(basic)")
                return
            }
            
            if let text = basic["text"] as? String where text.containsString("Battlecry") {
                minionsWithBattleCryEffect += 1
            }
            
            if cost == 5 {
                minionsWithACostOfFive += 1
            }
            
            if let rarity = basic["rarity"] as? String where rarity == "Common" {
                numberOfCommonMinions += 1
                sumCostOfCommonMinions += cost
            }
            
            if let attack = basic["attack"] as? Int, let health = basic["health"] as? Int where cost != 0 {
                var statsToCostRation = Double(attack + health) / Double(cost)
                
                notFreeMinions += 1
                statsToCostRatioSum += statsToCostRation
            }
        } else if type == "Weapon" {
            guard let durability = basic["durability"] as? Int else {
                print("No durability in \(basic)")
                return
            }
            
            if durability == 2 {
                weaponsWithDurabilityTwo += 1
            }
        }
    }
    
    print(minionsWithACostOfFive)
    print(weaponsWithDurabilityTwo)
    print(minionsWithBattleCryEffect)
    print(Float(sumCostOfCommonMinions) / Float(numberOfCommonMinions))
    print(statsToCostRatioSum / Double(notFreeMinions))
}

parseJSONAsDictionary(parsedHearthstoneJSON)
