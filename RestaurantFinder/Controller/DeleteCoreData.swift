//
//  DeleteCoreData.swift
//  RestaurantFinder
//
//  Created by Nischhal on 26.4.2022.
//

import Foundation
import CoreData

// Deleting data from Core-data
func batchDelete<T>(in context: NSManagedObjectContext, fetchRequest: NSFetchRequest<T>) throws {
    guard let request = fetchRequest as? NSFetchRequest<NSFetchRequestResult> else {
        return
    }
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    do {
        try context.execute(batchDeleteRequest)
    } catch {
        throw error
    }
}
