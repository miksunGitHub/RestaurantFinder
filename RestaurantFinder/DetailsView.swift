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
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack{
                AsyncImage(url: URL(string: restaurant.imageURL),
                           content: {
                    image in image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 270, maxHeight: 180)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange, lineWidth: 2))
                        .shadow(radius: 10)
                },
                           placeholder: {
                    ProgressView()
                })
                Text(restaurant.name).padding()
                HStack{
                    Text("Rating: ")
                    ForEach(0..<restaurant.rating){ i in
                        Image(systemName: "star.fill").resizable().frame(width: 10, height: 10)
                    }
                }
                Link("Website", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
                Text("Description:").padding()
                Text(restaurant.description).padding()
                Text("Address:\(restaurant.address)")
            }
        })
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var restaurant = Restaurant.sampleData[0]
    
    static var previews: some View {
        DetailsView(restaurant: restaurant)
    }
}
