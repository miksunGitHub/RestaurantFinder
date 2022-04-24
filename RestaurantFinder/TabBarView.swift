//
//  ContentView.swift
//  RestaurantFinder
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI


struct TabBarView: View {
    
//    init() {
//    UITabBar.appearance().backgroundColor = UIColor.blue
//
//    }
    
    var body: some View {
        TabView {
            HomeView(restaurants: RestaurantHC.sampleData)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            RestaurantsView(restaurants: RestaurantHC.sampleData)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Restaurants")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Favorites")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
            }
    
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
