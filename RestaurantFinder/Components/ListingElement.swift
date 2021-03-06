//
//  ListingElement.swift
//  RestaurantFinder
//
//  Created by Mikko on 28.4.2022.
//
// List element used in the restaurans view

import SwiftUI
import CoreLocation
import CoreData

struct ListingElement: View {
    
    var restaurants : FetchedResults<Restaurant>
    
    // background colors for the cards
    let colors: [Color] = [.customRed, .customBlue, .customGreen, .customOrange, .customYellow]
    
    let listLength: Int = 15
    
    var body: some View {
        
        ScrollView(.horizontal, content:{
            HStack{
                Spacer()
                    .frame(width: 10)
                ForEach(restaurants.prefix(listLength)){ restaurant in
                    let latitude = Double(restaurant.latitude ?? "60.16364")
                    let longitude = Double(restaurant.longitude ?? "24.947996")
                    let newRestaurant = RestaurantInfo(
                        name: restaurant.name ?? "no name",
                        imageURL: restaurant.imageurl ?? "no",
                        url: restaurant.url ?? "no url",
                        rating: restaurant.rating,
                        description: restaurant.desc ?? "no descpription",
                        address: restaurant.address ?? "no address",
                        priceLevel: restaurant.price,
                        coordinate: CLLocationCoordinate2D(
                            latitude: latitude ?? 60.16364,
                            longitude: longitude ?? 24.947996),
                        city: restaurant.city ?? "Helsinki",
                        email: restaurant.email ?? "no email",
                        phone: restaurant.phone ?? "no phone",
                        ranking: restaurant.ranking ?? "no ranking"
                    )
                    NavigationLink(destination: DetailsView(restaurant: newRestaurant)) {
                        ListElementView(restaurant: restaurant, color: colors.randomElement() ?? .customBlue)
                    }
                }
            }
        }
        )
    }
}



struct ListingElement_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
   
        @FetchRequest(
            entity: Restaurant.entity(), sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
        
        return ListingElement(restaurants: restaurants)
            .environment(\.managedObjectContext, viewContext)
    }
}


