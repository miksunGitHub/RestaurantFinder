//
//  RestaurantsView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import CoreData

struct RestaurantsView: View {
    
    let restaurants: [Restaurant]
    
    var body: some View {
        let restaurantsByRating=restaurants.sorted{$0.rating > $1.rating}
        
        NavigationView {
            ScrollView(.vertical, content:{
                VStack(alignment: .leading){
                    
                    
                    Text(NSLocalizedString("nearYou", comment: ""))
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        ScrollView(.horizontal, content:{
                                   HStack{
                                       ForEach(restaurants){ restaurant in
                                           NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                                               ListElementView(restaurant: restaurant)
                                           }
                                       }
                                   }
                        }
                        )
                    Text(NSLocalizedString("topRated", comment: ""))
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        ScrollView(.horizontal, content:{
                            HStack{
                                ForEach(restaurantsByRating){ restaurant in
                                    NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                                        ListElementView(restaurant: restaurant)
                                    }
                                }
                            }
                        }
                        )
                        Text(NSLocalizedString("byPrice", comment: ""))
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        ScrollView(.horizontal, content:{
                            HStack{
                                ForEach(restaurants){ restaurant in
                                    NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                                        ListElementView(restaurant: restaurant)
                                    }
                                }
                            }
                        }
                        )
                    }
            }
            )
        }.navigationBarHidden(true)
    }
    
}

struct RestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsView(restaurants: Restaurant.sampleData)
    }
}
