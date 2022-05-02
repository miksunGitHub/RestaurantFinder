//
//  ContentView.swift
//  RestaurantFinder
//
//  Created by iosdev on 7.4.2022.
//

import SwiftUI


struct TabBarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white

    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text(NSLocalizedString("home", comment: ""))
                }
            
            RestaurantsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text(NSLocalizedString("restaurants", comment: ""))
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text(NSLocalizedString("favourites", comment: ""))
                }
        }.accentColor(.customBlue)
            }
        
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
