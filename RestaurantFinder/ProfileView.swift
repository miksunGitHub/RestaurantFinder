//
//  ProfileView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    //@FetchRequest(sortDescriptors: []) var resturantArray: //FetchedResults<ResturantArray>
    @FetchRequest(
        entity: Restaurant.entity(), sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    
    
    
    var body: some View {
//                NavigationView {
//                    Text("ProfileView  content....")
//                }
        VStack{
            List{
                    ForEach(restaurants){ item in
                        
                        Text(item.name ?? "no name")
                    }
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
