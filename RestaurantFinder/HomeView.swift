//
//  HomeView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import MapKit
import SwiftUI

//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}

struct HomeView: View {
    
    let restaurants: [Restaurant]
    
    private let manage = CLLocationManager()
    
    @State private var region = MKCoordinateRegion (center: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328), //span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                                    latitudinalMeters: 10000, longitudinalMeters: 10000
    )
    
    @State var tracking : MapUserTrackingMode = .follow
    //    @State var manager = CLLocationManager()
    //    @State var managerDelegate = locationDelegate()
    
    //    let locations = [
    //        Location(name: "Toca", coordinate: CLLocationCoordinate2D(latitude: 60.1655, longitude: 24.951344)),
    //        Location(name: "Finlandia Caviar", coordinate: CLLocationCoordinate2D(latitude: 60.16717, longitude: 24.952295))
    //
    //    ]
    
    let mapFilters: MKPointOfInterestFilter = MKPointOfInterestFilter(including: [])
    
    var body: some View {
        NavigationView{
            VStack {
                Button("tracking") {
                    manage.desiredAccuracy = kCLLocationAccuracyBest
                    manage.requestWhenInUseAuthorization()
                    manage.startUpdatingHeading()
                }
                Map(coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow),
                    annotationItems: restaurants
                    
                )
                {
                    //            Location in MapMarker(coordinate: Location.coordinate, tint: Color.purple)
                    Restaurant in MapAnnotation(coordinate: Restaurant.coordinate) {
                        NavigationLink {
                            DetailsView(restaurant: Restaurant)
                        } label:{
                            Image(systemName: "house.circle")
                            //                        Circle()
                            //                            .stroke(.red, lineWidth: 3)
                                .frame(width: 15, height: 15)
                            //                            .onTapGesture {
                            //                                print("Tapped on \(Restaurant.name)")
                            //                            }
                            Text(Restaurant.name)
                        }
                    }
                }
            }
            .onAppear(){
                MKMapView.appearance().mapType = .mutedStandard
                MKMapView.appearance().pointOfInterestFilter = .some(mapFilters)
            }
        }
    }
}

// Location Manager Delegate
class locationDelegate : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // checking authorizition status
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // were going to use only when in use Key only....
        //        if manager.authorizationStatus() ==.authorizedWhenInUse{
        //
        //        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(restaurants: Restaurant.sampleData)
    }
}
