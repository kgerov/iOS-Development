//
//  Location.swift
//  VirtualTourist
//
//  Created by Konstantin Gerov on 8/23/16.
//  Copyright © 2016 Konstantin Gerov. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class Location: NSManagedObject, MKAnnotation {

    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entityForName("Location",
                                                       inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.latitude = latitude
            self.longitude = longitude
        }else{
            fatalError("Unable to find Entity name!")
        }
        
        
        
    }
    
    var coordinate: CLLocationCoordinate2D {
        
        get {
            var coord: CLLocationCoordinate2D = CLLocationCoordinate2D()
            coord.latitude = CDouble(self.latitude!)
            coord.longitude = CDouble(self.longitude!)
            
            return coord
        }
    }
}
