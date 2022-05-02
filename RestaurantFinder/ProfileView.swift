//
//  ProfileView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    //@FetchRequest(sortDescriptors: []) var resturantArray: //FetchedResults<ResturantArray>
    //    @FetchRequest(
    //        entity: Restaurant.entity(), sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
//        @StateObject var coreDataViewModel = CoreDataViewModel()
//    @State var vm = ApiService()
    @ObservedObject var coreDataViewModel = CoreDataViewModel()
    
    
    var body: some View {
//        NavigationView {
//            Button(action: add){
//                Text("Hello")
//            }
//
//        }
                VStack{
                    List{
                        ForEach(coreDataViewModel.fetchedEntities){ item in
                            Text(item.postalcode ?? "no name")
                            }

                    }
                }
    }
    
    func add(){
//        vm.resturants.forEach{ item in
//            print(item.name!)
//        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
