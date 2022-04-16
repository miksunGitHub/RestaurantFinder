//
//  HomeView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    
    @State private var region = MKCoordinateRegion (center: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328), //span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        latitudinalMeters: 10000, longitudinalMeters: 10000
    )
    
    @State var tracking : MapUserTrackingMode = .follow
//    @State var manager = CLLocationManager()
//    @State var managerDelegate = locationDelegate()
    
    let locations = [
        Location(name: "Toca", coordinate: CLLocationCoordinate2D(latitude: 60.1655, longitude: 24.951344)),
        Location(name: "Finlandia Caviar", coordinate: CLLocationCoordinate2D(latitude: 60.16717, longitude: 24.952295))
        
    ]
    
    let mapFilters: MKPointOfInterestFilter = MKPointOfInterestFilter(including: [])
    
    var body: some View {
       
        VStack {
            Map(coordinateRegion: $region,
                //annotationItems: locations,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $tracking,
                annotationItems: locations
                
            )
            {
                //            Location in MapMarker(coordinate: Location.coordinate, tint: Color.purple)
                Location in MapAnnotation(coordinate: Location.coordinate) {
                    VStack {
                        Image(systemName: "house.circle")
                            .frame(width: 15, height: 15)
                            .onTapGesture {
                                print("Tapped on \(Location.name)")
                            }
                        Text(Location.name)
                    }
                }
            }
        }
        .onAppear(){
//            manager.delegate = managerDelegate
//            localMap.pointOfInterestFilter = .some(MKPointOfInterestFilter(including: []))
              MKMapView.appearance().mapType = .mutedStandard
              MKMapView.appearance().pointOfInterestFilter = .some(mapFilters)
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
        HomeView()
    }
}
