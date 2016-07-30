//
//  animals.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = NSBundle.mainBundle().pathForResource("animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = NSData(contentsOfFile: pathForAnimalsJSON!)

/* Error object */
var parsingAnimalsError: NSError? = nil

/* Parse the data into usable form */
var parsedAnimalsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAnimalsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    guard let photosDictionary = dictionary["photos"] as? [String: AnyObject],
        let photosArray = photosDictionary["photo"] as? [[String: AnyObject]] else {
        
        print("No key 'photos' in array")
        return
    }
    
    print("Count: " + String(photosArray.count))
    
    for (index, photo) in photosArray.enumerate() {
        
        guard let content = photo["comment"] as? [String:String] else {
            print("There were no comments")
            return
        }
        
        guard let comment = content["_content"] as String! else {
            print("Failed to extract comment text")
            return
        }
        
        if (comment.containsString("interrufftion")) {
            print(index)
        }
        
        if (index == 2) {
            guard let url = photo["url_m"] as? String else {
                print("There was no url in \(photo)")
                return
            }
            
            print(url)
        }
    }

}

parseJSONAsDictionary(parsedAnimalsJSON)
