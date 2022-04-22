//
//  ProfileView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI

struct ProfileView: View {
    @FetchRequest(sortDescriptors: []) var rd: FetchedResults<Test>
    
    var body: some View {
//        NavigationView {
//            Text("ProfileView  content....")
//        }
        List(rd){item in
            Text(item.name ?? "Unknown")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
