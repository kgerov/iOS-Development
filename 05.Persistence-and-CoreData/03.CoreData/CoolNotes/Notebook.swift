//
//  Notebook.swift
//  CoolNotes
//
//  Created by Konstantin Gerov on 8/18/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import CoreData


class Notebook: NSManagedObject {

    convenience init(name: String, context: NSManagedObjectContext) {
        let ent = NSEntityDescription.entityForName("Notebook", inManagedObjectContext: context)
        self.init(entity: ent!, insertIntoManagedObjectContext: context)
        self.name = name
        self.creationDate = NSDate()
    }
}
