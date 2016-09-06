//
//  Meal.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import CoreData


class Meal: NSManagedObject {
    
    convenience init(title: String, ingridients: String, type: String, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entityForName("Meal", inManagedObjectContext: context) {
            
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.title = title
            self.ingridients = ingridients
            self.type = type
        } else {
            fatalError("No entity with this name")
        }
    }
}
