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
                        .tracking(1)
                        .font(.system(size: 28.0, weight: .bold, design: .serif))
                        .foregroundColor(Color.white)
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .frame(alignment: .topLeading)
                    LazyVGrid(columns: columns,
                              alignment: .center, spacing: 10){
                        ForEach(favourites){ favourite in
                            let latitude = Double(favourite.latitude ?? "60.16364")
                            let longitude = Double(favourite.longitude ?? "24.947996")
                            let newFavourite = RestaurantHC(
                                name: favourite.name ?? "no name",
                                imageURL: favourite.imageurl ?? "no",
                                url: favourite.url ?? "no url",
                                rating: favourite.rating,
                                description: favourite.desc ?? "no description",
                                address: favourite.address ?? "no address",
                                priceLevel: favourite.price,
                                coordinate: CLLocationCoordinate2D(
                                    latitude: latitude ?? 60.16364,
                                    longitude: longitude ?? 24.947996),
                                city: favourite.city ?? "no city",
                                email: favourite.email ?? "no email",
                                phone: favourite.phone ?? "no phone",
                                ranking: favourite.ranking ?? "no ranking"
                            )
                            
                            NavigationLink(destination: DetailsView(restaurant: newFavourite)) {
                                FavouriteListElementView(favourite: favourite, color: colors.randomElement() ?? .gray)
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
