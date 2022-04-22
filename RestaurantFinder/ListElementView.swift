//
//  ListElementView.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 11.4.2022.
//

import SwiftUI
import CoreData

struct ListElementView: View {
    let restaurant: RestaurantHC
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Favourite.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.rating, ascending: true)]) var favourites: FetchedResults<Favourite>

    var body: some View {
        VStack{
            Spacer()
                .frame(width: 10)
            AsyncImage(url: URL(string: restaurant.imageURL),
                       content: {
                            image in image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 150, maxHeight: 100)
                                        .scaledToFill()
                                        .overlay(
                                            Image(systemName: "bookmark")
                                                .gesture(
                                                    TapGesture().onEnded{
                                                        addItem()
                                                    }
                                                )
                                                .foregroundColor(Color.blueMansell)
                                                .padding(.top, 15)
                                                .padding(.trailing, 10)
                                                .font(Font.system(size: 20, weight: .semibold))
                                                ,
                                            alignment: .topTrailing
                                        )
                                       },
                                       placeholder: {
                                           ProgressView()
                                   })
                
            Spacer()
            Text(restaurant.name)
                .foregroundColor(Color.white)
            HStack{
                ForEach(0..<Int(restaurant.rating)){ i in
                        Image(systemName: "star.fill")
                        .resizable().frame(width: 14, height: 14)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
                .frame(height: 20)
        }
        //.padding(10)
        .frame(width: 150, height: 160)
        .border(Color.blueMansell)
        .background(Color.blueMansell)
        .cornerRadius(10)
    }
    
    private func addItem() {
        withAnimation {
            let newFavourite = Favourite(context: viewContext)
            newFavourite.name = restaurant.name
            newFavourite.rating = restaurant.rating
            newFavourite.price = restaurant.priceLevel
            newFavourite.address = restaurant.address
            newFavourite.url = restaurant.imageURL
            newFavourite.desc = restaurant.description
            print(newFavourite)
            saveItems()
        }
    }

    private func saveItems(){
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ListElementView_Previews: PreviewProvider {
    static var restaurant = RestaurantHC.sampleData[0]

    
    static var previews: some View {
        ListElementView(restaurant: restaurant)
    }
}
