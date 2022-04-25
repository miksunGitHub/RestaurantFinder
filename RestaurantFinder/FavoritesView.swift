//
//  FavoritesView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import CoreData
import CoreLocation

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Favourite.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.rating, ascending: true)]) var favourites: FetchedResults<Favourite>
    
    let colors: [Color] = [.customRed, .customBlue, .customGreen, .customOrange, .customYellow]
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
                ScrollView(.vertical, content:{
                    VStack(alignment: .leading){
                Text(NSLocalizedString("favorites", comment: ""))
                    .font(.system(size: 28.0, weight: .bold, design: .serif))
                    .foregroundColor(Color.white)
                    .padding(.init(top: 20, leading: 10, bottom: 10, trailing: 10))
                    .frame(alignment: .topLeading)
            LazyVGrid(columns: columns,
                      alignment: .leading, spacing: 10){
                                   ForEach(favourites){ favourite in
                                       let newFavourite = RestaurantHC(
                                        name: favourite.name ?? "no name",
                                        imageURL: favourite.url ?? "no",
                                        rating: favourite.rating ,
                                        description: favourite.desc ?? "no descriotion",
                                        address: favourite.address ?? "no address",
                                        priceLevel: favourite.price,
                                        coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996))
                                       
                                       NavigationLink(destination: DetailsView(restaurant: newFavourite)) {
                                           ListElementView(restaurant: newFavourite, color: colors.randomElement() ?? .gray)
                                       }
                                   }
                                   
                               }
                        Spacer()
                    }.padding(10)
                }
                )
                .background(Color.colorDarkGrey)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .padding(.bottom, 0.5)
            }
    }
        
    
}
                            


struct FavoritesView_Previews: PreviewProvider {
    
    static var previews: some View {
        FavoritesView()
    }
}
