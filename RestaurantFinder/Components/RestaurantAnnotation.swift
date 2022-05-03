//
//  RestaurantAnnotation.swift
//  RestaurantFinder
//
//  Map annotation for restaurant locations
//
//  Created by iosdev on 27.4.2022.
//

import SwiftUI
import MapKit
import CoreLocation

// set restaurant annotation, pop-up window, and direction calculation
struct RestaurantAnnotation: View {
    @State private var showTitle = true
    @State private var defaultColor = true
    
    let restaurant: RestaurantInfo
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
                        //let user select transportation method
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
                            // call call function to calculate direcation
                            findDirections()
                            //set showDirections to true and display the turn by turn route by sheet on the HomeView
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
    // function for computing direction between source and destination with MKDirections utility object
    func findDirections(){
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(placemark: MKPlacemark(coordinate: LocationHelper.currentLocation, addressDictionary: nil)))
        request.destination = MKMapItem(placemark: MKPlacemark(placemark: MKPlacemark(coordinate: restaurant.coordinate, addressDictionary: nil)))
        request.requestsAlternateRoutes = false
        // get distance info and add to directions
        let distance = LocationHelper.currentLocation.distance(from: restaurant.coordinate)
        // let user to choose transportation method
        request.transportType = walking ? .walking : .automobile
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {response, error in
            if response?.routes != nil {
                for route in (response?.routes)! {
                    routeSteps = [RouteSteps(step: NSLocalizedString("distance", comment: "") + String(Int(distance)) + "m" )]
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
