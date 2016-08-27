//
//  Photo+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/26/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Photo {

    @NSManaged var dateCreated: NSDate?
    @NSManaged var imageData: NSData?
    @NSManaged var url: String?
    @NSManaged var location: Location?

}
