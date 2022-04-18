//
//  RestaurantFinderApp.swift
//  RestaurantFinder
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI

@main
struct RestaurantFinderApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabBarView()
            }
            .navigationBarHidden(true)
        }
    }
}
