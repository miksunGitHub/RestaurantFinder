//
//  RestaurantsView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI


struct RestaurantsView: View {
    
    let restaurants: [RestaurantHC]
    
    let colors: [Color] = [.customRed, .customBlue, .customGreen, .customOrange, .customYellow]
    
    var body: some View {
        let restaurantsByRating=restaurants.sorted{$0.rating > $1.rating}
        
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
                                       ForEach(restaurants){ restaurant in
                                           
                                           NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                                               ListElementView(restaurant: restaurant, color: colors.randomElement() ?? .customBlue)
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
                                ForEach(restaurantsByRating){ restaurant in
                                    NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                                        ListElementView(restaurant: restaurant, color: colors.randomElement() ?? .customBlue)
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
                                ForEach(restaurants){ restaurant in
                                    NavigationLink(destination: DetailsView(restaurant: restaurant)) {
                                        ListElementView(restaurant: restaurant, color: colors.randomElement() ?? .customBlue)
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
        RestaurantsView(restaurants: RestaurantHC.sampleData)
    }
}
