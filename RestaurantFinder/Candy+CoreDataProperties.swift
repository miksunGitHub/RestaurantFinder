//
//  Candy+CoreDataProperties.swift
//  RestaurantFinder
//
//  Created by Nischhal on 22.4.2022.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknow Candy"
    }

}

extension Candy : Identifiable {

}
