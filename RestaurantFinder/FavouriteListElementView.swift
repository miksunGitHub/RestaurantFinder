//
//  FavouriteListElementView.swift
//  RestaurantFinder
//
//  Created by Mikko on 28.4.2022.
//

import SwiftUI
import CoreData

struct FavouriteListElementView: View {
    @ObservedObject var favourite: Favourite
    let color: Color
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Favourite.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.rating, ascending: true)]) var favourites: FetchedResults<Favourite>
    
    
    var body: some View {
        VStack(){
            Spacer()
                .frame(width: 10)
            //AsyncImage(url: URL(string: restaurant.imageURL),
            AsyncImage(url: URL(string: favourite.imageurl ?? "https://via.placeholder.com/150/208aa3/208aa3?Text=RestaurantFinder"),
                       content: {
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 90, alignment: .center)
                //.scaledToFill()
                    .background(Color.colorDarkGrey)
                    .overlay(
                        Image(systemName: "bookmark.slash.fill")
                            .gesture(
                                TapGesture().onEnded{
                                    deleteItem()
                                }
                            )
                            .foregroundColor(color)
                            .padding(.top, 15)
                            .padding(.trailing, 20)
                            .font(Font.system(size: 18, weight: .semibold))
                        ,
                        alignment: .topTrailing
                    )
            },
                       placeholder: {
                ProgressView()
            })
            
            Spacer()
            Text(favourite.name ?? "no name")
                .foregroundColor(Color.white)
                .font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 18))
            Spacer()
            HStack{
                ForEach(0..<Int(round(favourite.rating))){ i in
                    Image(systemName: "star")
                        .resizable().frame(width: 14, height: 14)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
                .frame(height: 20)
        }
        .frame(width: 130, height: 150)
        .border(color, width: 2)
        .background(color)
        .cornerRadius(10)
    }
    
    private func deleteItem(){
        viewContext.delete(favourite)
        saveItems()
    }
    
    private func saveItems(){
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print(nsError)
        }
    }
}

struct FavouriteListElementView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        let newRestaurant = Favourite(context: viewContext)
        newRestaurant.name = "Baskeri & Basso"
        newRestaurant.url = "https://basbas.fi/"
        newRestaurant.imageurl = "https://via.placeholder.com/150/208aa3/208aa3?Text=RestaurantFinder"
        newRestaurant.address = "Ulappakatu 3, Espoo"
        newRestaurant.desc = "no description"
        newRestaurant.rating = 4
        newRestaurant.price = 4
        newRestaurant.latitude = "60.157803"
        newRestaurant.longitude = "24.934328"
        newRestaurant.postalcode = "00200"
        newRestaurant.city = "Helsinki"
        newRestaurant.email = "bas@bas.fi"
        newRestaurant.phone = "0504673400"
        newRestaurant.ranking = "no ranking"
        
        return FavouriteListElementView(favourite: newRestaurant, color: .gray)
            .environment(\.managedObjectContext, viewContext)
    }
}
