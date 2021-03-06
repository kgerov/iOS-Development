//
//  Location+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/24/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var subtitle: String?
    @NSManaged var title: String?
    @NSManaged var hasBeenOpened: NSNumber?
    @NSManaged var photos: NSSet?

}
