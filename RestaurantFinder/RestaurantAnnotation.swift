//
//  MapAnnotation.swift
//  RestaurantFinder
//
//  Created by iosdev on 27.4.2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct RestaurantAnnotation: View {
    @State private var showTitle = true
    @State private var defaultColor = true
    let restaurant: RestaurantHC
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack {
                HStack {
                    Text(restaurant.name)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "location")
                        .foregroundColor(.red)
                        .frame(width: 15, height: 15)
                        .onTapGesture {
                            print("Directions to \(String(describing: restaurant.name))")
                            
                        }
                }
                HStack {
                    Text(restaurant.address)
                    Spacer()
                }
                HStack {
                    NavigationLink {
                        DetailsView(restaurant: restaurant)
                    } label: {
                        Text("Details")
                    }
                    Spacer()
                }
                
                
            }
            .padding(5)
            .background(Color(.white))
            .cornerRadius(10)
            .opacity(showTitle ? 0 : 1)
            
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
    }
}


