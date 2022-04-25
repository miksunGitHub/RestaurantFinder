//
//  RestaurantsView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import CoreLocation
import CoreData

struct RestaurantsView: View {
    
    @FetchRequest(
        entity: Restaurant.entity(), sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    
    //let restaurants: [RestaurantHC]
    
    let colors: [Color] = [.customRed, .customBlue, .customGreen, .customOrange, .customYellow]
    
    var body: some View {
        //let restaurantsByRating=restaurants.sorted{$0.rating > $1.rating}
        
        
        
        NavigationView {
            
            ScrollView(.vertical, content:{
                VStack(alignment: .leading){
                    Text(NSLocalizedString("nearYou", comment: ""))
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                        .padding(.init(top: 20, leading: 10, bottom: 10, trailing: 10))
                        ScrollView(.horizontal, content:{
                                   HStack{
                                       Spacer()
                                           .frame(width: 10)
                                       ForEach(restaurants.prefix(5)){ restaurant in
                                           let newRestaurant = RestaurantHC(
                                            name: restaurant.name ?? "no name",
                                            imageURL: restaurant.url ?? "no",
                                            rating: restaurant.rating ?? 1,
                                            description: restaurant.desc ?? "no descpription",
                                            address: restaurant.address ?? "no address",
                                            priceLevel: restaurant.price ?? 5,
                                            coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996))
                                           NavigationLink(destination: DetailsView(restaurant: newRestaurant)) {
                                               ListElementView(restaurant: newRestaurant, color: colors.randomElement() ?? .customBlue)
                                           }
                                       }
                                       }
                                   }
                        )
                    Text(NSLocalizedString("topRated", comment: ""))
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        ScrollView(.horizontal, content:{
                            HStack{
                                Spacer()
                                    .frame(width: 10)
                                ForEach(restaurants.prefix(5)){ restaurant in
                                    let newRestaurant = RestaurantHC(
                                     name: restaurant.name ?? "no name",
                                     imageURL: restaurant.url ?? "no",
                                     rating: restaurant.rating ?? 1,
                                     description: restaurant.desc ?? "no description",
                                     address: restaurant.address ?? "no address",
                                     priceLevel: restaurant.price ?? 5,
                                     coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996))
                                    NavigationLink(destination: DetailsView(restaurant: newRestaurant)) {
                                        ListElementView(restaurant: newRestaurant, color: colors.randomElement() ?? .customBlue)
                                    }
                                }
                            }
                        }
                        )
                    Text(NSLocalizedString("byPrice", comment: ""))
                    .font(.system(size: 28.0, weight: .bold, design: .serif))
                    .foregroundColor(Color.white)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                    ScrollView(.horizontal, content:{
                            HStack{
                                Spacer()
                                    .frame(width: 10)
                                ForEach(restaurants.prefix(5)){ restaurant in
                                    let newRestaurant = RestaurantHC(
                                     name: restaurant.name ?? "no name",
                                     imageURL: restaurant.url ?? "no",
                                     rating: restaurant.rating ?? 1,
                                     description: restaurant.desc ?? "no description",
                                     address: restaurant.address ?? "no address",
                                     priceLevel: restaurant.price ?? 5,
                                     coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996))
                                    NavigationLink(destination: DetailsView(restaurant: newRestaurant)) {
                                        ListElementView(restaurant: newRestaurant, color: colors.randomElement() ?? .customBlue)
                                    }
                                }
                            }
                        }
                        )
                    }
                Spacer()
                    .frame(height: 20)
            }
                       
            ).background(Color.colorDarkGrey)
                .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .padding(.bottom, 0.5)
            }
        
    }
    
}

struct RestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsView()
    }
}
