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
    @Binding var routeSteps : [RouteSteps]
    @Binding var showDirections : Bool
    @Binding var walking: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Text(restaurant.name)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        self.walking.toggle()
                    }, label: {
                        Text(walking ? NSLocalizedString("walk", comment: "") : NSLocalizedString("car", comment: ""))
                    })
                    Spacer()
                    Image(systemName: "location")
                        .foregroundColor(.red)
                        .frame(width: 15, height: 15)
                        .onTapGesture {
                            print("Directions to \(String(describing: restaurant.name))")
                            findDirections()
                            self.showDirections.toggle()
                            
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
                        Text(NSLocalizedString("details", comment: ""))
                    }
                    Spacer()
                }
                
                
            }
            .padding(5)
            .background(Color(.white))
            .cornerRadius(10)
            .opacity(showTitle ? 0 : 1)
            
            VStack {
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
            }.onTapGesture {
                withAnimation(.easeInOut) {
                    showTitle.toggle()
                }
            }
            Text(restaurant.name)
        }
    }
    func findDirections(){
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(placemark: MKPlacemark(coordinate: LocationHelper.currentLocation, addressDictionary: nil)))
        
        request.destination = MKMapItem(placemark: MKPlacemark(placemark: MKPlacemark(coordinate: restaurant.coordinate, addressDictionary: nil)))
        
        request.requestsAlternateRoutes = false
        
        let distance = LocationHelper.currentLocation.distance(from: restaurant.coordinate)
        
        request.transportType = walking ? .walking : .automobile
        //        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {response, error in
            
            if response?.routes != nil {
                for route in (response?.routes)! {
                    routeSteps = [RouteSteps(step: "Distance: \(Int(distance))m")]
                    
                    for step in route.steps {
                        routeSteps.append(RouteSteps(step: step.instructions))
                    }
                }
            } else {
                routeSteps = [RouteSteps(step: "Directions calculation failed, because you are not located in the same city as the restaurant you selected")]
            }
            
        })
        
        
    }
}


