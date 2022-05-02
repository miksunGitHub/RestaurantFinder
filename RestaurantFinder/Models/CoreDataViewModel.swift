//
//  CoreDataViewModel.swift
//  RestaurantFinder
//
//  Created by Nischhal on 30.4.2022.
//

import Foundation
import SwiftUI
import CoreData

// Core data view model
class CoreDataViewModel: ObservableObject {
//    @Environment(\.managedObjectContext) private var context
    let container: NSPersistentContainer
//    @State var apiService = ApiService()
    @Published var fetchedEntities: [Restaurant] = []
    @State var deleteData = DeleteData()
    
    init() {
        container = NSPersistentContainer(name: "RestaurantFinder")
        container.loadPersistentStores{(desciption, error) in
            if let error = error {
                print("Error loading core data. \(error)")
            }else{
                print("Success")
            }
        }
    }
    
    func fetchFromCoreData(){
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do{
            fetchedEntities =  try container.viewContext.fetch(request)
        }catch let error {
            print("Error fetching: \(error)")
        }
    }
    
    // adding resturants to the core data
    func addResturants(_ resturants: [Resturant]){
         deleteCoreData()
        resturants.forEach{ item in
            let newRestaurant = Restaurant(context: container.viewContext)
            newRestaurant.name = String(item.name ?? "no name")
            newRestaurant.url = String(item.photo?.images?.medium?.url ?? "https://via.placeholder.com/150/208aa3/208aa3?Text=RestaurantFinder")
            newRestaurant.address = String(item.address_obj?.street1 ?? "no address")
            newRestaurant.desc = String(item.description ?? "no description")
            newRestaurant.rating = Double(item.rating ?? "1.0") ?? 1.0
//            newRestaurant.price = Int64(5)
            newRestaurant.latitude = item.latitude
            newRestaurant.longitude = item.longitude
            newRestaurant.postalcode = item.address_obj?.postalcode ?? "Postal code not found"
            newRestaurant.review = item.write_review ?? "Review link not found"
            saveEntity()
        }
        fetchFromCoreData()
    }
    
    // Saving core data
    func saveEntity(){
        do {
            try container.viewContext.save()
            fetchFromCoreData()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Deleting values from core data
    private func deleteCoreData(){
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        do {
            let data = try context.fetch(fetchRequest)
            if data.count > 0 {
                try deleteData.batchDelete(in: context, fetchRequest: fetchRequest)
            }
        } catch {
            print("Error deleting core-data")
        }
    }
    
}


