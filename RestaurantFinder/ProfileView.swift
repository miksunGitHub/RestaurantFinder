//
//  ProfileView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        //        NavigationView {
        //            Text("ProfileView  content....")
        //        }
        VStack{
            List{
                ForEach(countries, id: \.self){ country in
                    Section(country.wrappedFullName){
                        ForEach(country.candyArray, id: \.self){candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add"){
                let arrayData = ["Hello", "Hi", "Bye"]
                arrayData.forEach{(item) in
                    let candy = Candy(context: moc)
                    candy.name = item
                    candy.origin = Country(context: moc)
                    candy.origin?.shortName = "UK"
                    candy.origin?.fullName = "United kingdom"
                }
                //                let candy1 = Candy(context: moc)
                //                candy1.name = "Mars"
                //                candy1.origin = Country(context: moc)
                //                candy1.origin?.shortName = "UK"
                //                candy1.origin?.fullName = "United kingdom"
                //
                //                let candy2 = Candy(context: moc)
                //                candy2.name = "Kitkat"
                //                candy2.origin = Country(context: moc)
                //                candy2.origin?.shortName = "UK"
                //                candy2.origin?.fullName = "United kingdom"
                //
                //                let candy3 = Candy(context: moc)
                //                candy3.name = "Twix"
                //                candy3.origin = Country(context: moc)
                //                candy3.origin?.shortName = "UK"
                //                candy3.origin?.fullName = "United kingdom"
                //
                //                let candy4 = Candy(context: moc)
                //                candy4.name = "Tob"
                //                candy4.origin = Country(context: moc)
                //                candy4.origin?.shortName = "CH"
                //                candy4.origin?.fullName = "Finland"
                
                try? moc.save()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
