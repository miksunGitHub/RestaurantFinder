//
//  ResturantArray+CoreDataProperties.swift
//  RestaurantFinder
//
//  Created by Nischhal on 23.4.2022.
//
//

import Foundation
import CoreData


extension ResturantArray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResturantArray> {
        return NSFetchRequest<ResturantArray>(entityName: "ResturantArray")
    }

    @NSManaged public var resturantObject: NSSet?
    
    public var resturantArray: [ResturantObject] {
        let set = resturantObject as? Set<ResturantObject> ?? []
        
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for resturantObject
extension ResturantArray {

    @objc(addResturantObjectObject:)
    @NSManaged public func addToResturantObject(_ value: ResturantObject)

    @objc(removeResturantObjectObject:)
    @NSManaged public func removeFromResturantObject(_ value: ResturantObject)

    @objc(addResturantObject:)
    @NSManaged public func addToResturantObject(_ values: NSSet)

    @objc(removeResturantObject:)
    @NSManaged public func removeFromResturantObject(_ values: NSSet)

}

extension ResturantArray : Identifiable {

}
