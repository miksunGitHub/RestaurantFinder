//
//  ListElementView.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 11.4.2022.
//

import SwiftUI
import CoreData

struct ListElementView: View {
    @ObservedObject var restaurant: Restaurant
    let color: Color
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //fetch elements from Favourite entity
    @FetchRequest(
        entity: Favourite.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.rating, ascending: true)])
    var favourites: FetchedResults<Favourite>
    
    
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack(){
            Spacer()
                .frame(width: 10)
            AsyncImage(url: URL(string: restaurant.imageurl ?? "https://via.placeholder.com/150/208aa3/208aa3?Text=RestaurantFinder"),
                       content: {
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 90, alignment: .center)
                    .background(Color.colorDarkGrey)
                    .overlay(
                        Image(systemName: "bookmark.fill")
                            .gesture(
                                TapGesture().onEnded{
                                    var notInFavourite = true
                                    // compare the name of this restaurant with the element in Favourite entity, if there is match set notInFavourite to false
                                    favourites.forEach{
                                        favourite in
                                        if favourite.name == restaurant.name {
                                            notInFavourite = false
                                            showingAlert = true
                                        }
                                    }
                                    // add the restanrant to Favourite list when notInFavourite is true
                                    if notInFavourite {
                                        addItem()
                                    }
                                    
                                }
                            )
                            .foregroundColor(color)
                            .padding(.top, 15)
                            .padding(.trailing, 20)
                            .font(Font.system(size: 18, weight: .semibold))
                        // show alert message when showingAlert is true
                            .alert("This restaurant is already in your Favourite list!", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        ,
                        alignment: .topTrailing
                    )
            },
                       placeholder: {
                ProgressView()
            })
            
            Spacer()
            Text(restaurant.name ?? "no name")
                .foregroundColor(Color.white)
                .font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 18))
            Spacer()
            HStack{
                ForEach(0..<Int(round(restaurant.rating))){ i in
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
    
    // function to create a new favourite to core data
    private func addItem() {
        withAnimation {
            let newFavourite = Favourite(context: viewContext)
            newFavourite.name = restaurant.name
            newFavourite.rating = restaurant.rating
            newFavourite.price = restaurant.price
            newFavourite.address = restaurant.address
            newFavourite.url = restaurant.url
            newFavourite.imageurl = restaurant.imageurl
            newFavourite.desc = restaurant.desc
            newFavourite.phone = restaurant.phone
            newFavourite.email = restaurant.email
            newFavourite.ranking = restaurant.ranking
            newFavourite.city = restaurant.city
            newFavourite.latitude = restaurant.latitude
            newFavourite.longitude = restaurant.longitude
            newFavourite.postalcode = restaurant.postalcode
            saveItems()
        }
    }
    
    // function to save the items
    private func saveItems(){
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print(nsError)
        }
    }
}

struct ListElementView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        let newRestaurant = Restaurant(context: viewContext)
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
        newRestaurant.phone = "0428347473"
        newRestaurant.ranking = "no ranking"
        
        return ListElementView(restaurant: newRestaurant, color: .gray)
            .environment(\.managedObjectContext, viewContext)
    }
}
