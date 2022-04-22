//
//  FavoritesView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Favourite.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.rating, ascending: true)]) var favourites: FetchedResults<Favourite>
    
    var body: some View {
        NavigationView {
            VStack{
                Button(action: {
                    print(favourites)
                }, label: {
                    Text("print")
                })
                Text("FavoritesView  content....")
                }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            
    }
}
