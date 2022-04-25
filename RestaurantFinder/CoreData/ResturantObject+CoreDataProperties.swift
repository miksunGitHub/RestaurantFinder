//
//  ResturantObject+CoreDataProperties.swift
//  RestaurantFinder
//
//  Created by Nischhal on 23.4.2022.
//
//

import Foundation
import CoreData


extension ResturantObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResturantObject> {
        return NSFetchRequest<ResturantObject>(entityName: "ResturantObject")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: ResturantArray?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }

}

extension ResturantObject : Identifiable {

}
