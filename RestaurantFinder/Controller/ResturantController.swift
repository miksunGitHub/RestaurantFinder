//
//  ResturantController.swift
//  RestaurantFinder
//
//  Created by Nischhal on 23.4.2022.
//

import Foundation
import CoreData

class ResturantController: ObservableObject{
    let container = NSPersistentContainer(name: "ResturantFinder")
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error {
                print("Core Data fail to load: \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
