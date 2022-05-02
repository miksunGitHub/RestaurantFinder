//
//  DetailsView.swift
//  RestaurantFinder
//
//  Created by iosdev on 13.4.2022.
//

import SwiftUI

struct DetailsView: View {
    let restaurant: RestaurantHC
    
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
                // Button("Click", action: {getFonts()})
                Text(restaurant.name).font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 30)).foregroundColor(.colorBrown)
                VStack(alignment: .leading){
                    HStack{
                        Text("Rating: ").font(.custom(FontsName.EBGaraRomanMedium.rawValue, size: 20)).foregroundColor(.colorDarkPurple)
                        ForEach(0..<Int(restaurant.rating)){ i in
                            Image(systemName: "star.fill").resizable().frame(width: 10, height: 10)
                        }
                    }
                    Link("Website", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!).font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 20))
                    Text("Description:").font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 20)).padding([.top],1).foregroundColor(.colorDarkPurple)
                    Text(restaurant.description).font(.custom(FontsName.EBGaraRomanMedium.rawValue, size: 20)).padding([.top],0.5).foregroundColor(.colorDarkPurple)
                    Text("Address:\(restaurant.address)").font(.custom(FontsName.EBGaraRomanMedium.rawValue, size: 20)).padding(.top).foregroundColor(.colorDarkPurple)
                }
            }
        })
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var restaurant = RestaurantHC.sampleData[0]
    
    static var previews: some View {
        DetailsView(restaurant: restaurant)
    }
}
