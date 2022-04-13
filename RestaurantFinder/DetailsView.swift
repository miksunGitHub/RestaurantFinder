//
//  DetailsView.swift
//  RestaurantFinder
//
//  Created by iosdev on 13.4.2022.
//

import SwiftUI

struct DetailsView: View {
    let restaurant: Restaurant
    
    var body: some View {
        Text(restaurant.name)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var restaurant = Restaurant.sampleData[0]
    
    static var previews: some View {
        DetailsView(restaurant: restaurant)
    }
}
