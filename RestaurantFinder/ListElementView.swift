//
//  ListElementView.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 11.4.2022.
//

import SwiftUI

struct ListElementView: View {
    let restaurant: Restaurant

    var body: some View {
        VStack{
            Spacer()
            AsyncImage(url: URL(string: restaurant.imageURL),
                       content: {
                            image in image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 400, maxHeight: 200)
                                       },
                                       placeholder: {
                                           ProgressView()
                                   })
            Spacer()
            Text(restaurant.name)
            HStack{
                ForEach(0..<restaurant.rating){ i in
                        Image(systemName: "star.fill").resizable().frame(width: 10, height: 10)
                }
            }
            Spacer()
        }
        .frame(width: 150, height: 120)
        .border(Color.gray)
        .padding(10)
        // .background(Color.cyan)
    }
}

struct ListElementView_Previews: PreviewProvider {
    static var restaurant = Restaurant.sampleData[0]
    
    static var previews: some View {
        ListElementView(restaurant: restaurant)
    }
}
