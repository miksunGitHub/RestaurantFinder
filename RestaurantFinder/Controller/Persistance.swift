//
//  Persistence.swift
//  CoreDataTesting
//
//  Created by iosdev on 19.4.2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for x in 0..<10 {
            let newRestaurant = Favourite(context: viewContext)
            newRestaurant.name = "Cella \(x)"
            newRestaurant.rating = 5
            newRestaurant.price = 4
            newRestaurant.desc = "Nice place"
            newRestaurant.address = "Fleminginkatu 21"
            newRestaurant.url = "https://www.ravintolacella.fi/"
            newRestaurant.imageurl = "https://media-cdn.tripadvisor.com/media/photo-l/13/44/01/be/photo9jpg.jpg"
            newRestaurant.latitude = "60.163624"
            newRestaurant.longitude = "24.947996"
            newRestaurant.postalcode = "00530"
            newRestaurant.city = "Helsinki"
            newRestaurant.email = "cella@cella.fi"
            newRestaurant.phone = "0442932628"
            newRestaurant.ranking = "no ranking"
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RestaurantFinder")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
