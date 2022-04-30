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
    
    @FetchRequest(
        entity: Restaurant.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Restaurant.rating, ascending: false)]) var restaurantsByRating: FetchedResults<Restaurant>
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, content:{
                VStack(alignment: .leading){
                    Text(NSLocalizedString("nearYou", comment: ""))
                        .tracking(1)
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                        .padding(.init(top: 20, leading: 10, bottom: 10, trailing: 10))
                    
                    ListingElement(restaurants: restaurants)
                    
                    
                    Text(NSLocalizedString("topRated", comment: ""))
                        .tracking(1)
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    ListingElement(restaurants: restaurantsByRating)
                    
                    Text(NSLocalizedString("byPrice", comment: ""))
                        .tracking(1)
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    ListingElement(restaurants: restaurants)
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
