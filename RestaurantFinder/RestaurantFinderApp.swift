//
//  RestaurantFinderApp.swift
//  RestaurantFinder
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI

@main
struct RestaurantFinderApp: App {
    let location =  UserDefaults.standard.string(forKey: "city") ?? "Helsinki"
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabBarView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
