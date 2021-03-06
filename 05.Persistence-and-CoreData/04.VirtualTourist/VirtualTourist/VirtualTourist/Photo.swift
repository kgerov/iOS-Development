//
//  Photo.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/23/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import CoreData


class Photo: NSManagedObject {

    convenience init(url: String, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entityForName("Photo", inManagedObjectContext: context) {
            
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.url = url
            self.dateCreated = NSDate()
        } else {
            fatalError("No entity with this name")
        }
    }
}
