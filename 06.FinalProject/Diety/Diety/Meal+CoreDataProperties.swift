//
//  Meal+CoreDataProperties.swift
//  Diety
//
//  Created by Konstantin Gerov on 9/4/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Meal {

    @NSManaged var title: String?
    @NSManaged var ingridients: String?
    @NSManaged var type: String?

}
