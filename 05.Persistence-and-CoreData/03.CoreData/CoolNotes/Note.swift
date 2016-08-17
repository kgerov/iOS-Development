//
//  Note.swift
//  CoolNotes
//
//  Created by Konstantin Gerov on 8/18/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import CoreData


class Note: NSManagedObject {

    convenience init(text: String = "New Note", context: NSManagedObjectContext) {
        let ent = NSEntityDescription.entityForName("Note", inManagedObjectContext: context)
        self.init(entity: ent!, insertIntoManagedObjectContext: context)
        self.text = text
        self.creationDate = NSDate()
    }
    
    var formattedAge: String {
        get {
            let formatter = NSDateFormatter()
            formatter.timeStyle = .NoStyle
            formatter.dateStyle = .ShortStyle
            formatter.doesRelativeDateFormatting = true
            formatter.locale = NSLocale.currentLocale()
            
            return formatter.stringFromDate(self.creationDate!)
        }
    }
}
