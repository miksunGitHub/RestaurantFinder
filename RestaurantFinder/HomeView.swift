//
//  HomeView.swift
//  RestaurantFinder
//
//  Created by Alex on 11.4.2022.
//

//60,159803 24,934328

import SwiftUI
import MapKit
import CoreLocation

struct RouteSteps: Identifiable {
    let id = UUID()
    let step : String
}

struct Location : Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let restaurants: [RestaurantHC]
    
    @State private var destination = CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)
    
    @State private var point = CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328), span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
    
    @State var routeSteps : [RouteSteps] = []
    
    @State var annotations = [
        Location(name: "Baskeri & Basso", coordinate: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)),
        Location(name: "Toca", coordinate: CLLocationCoordinate2D(latitude: 60.1655, longitude: 24.951344)),
        Location(name: "Finlandia Caviar", coordinate: CLLocationCoordinate2D(latitude: 60.16717, longitude: 24.952295)),
        Location(name: "Spis", coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996)),
        Location(name: "my restaurant", coordinate: CLLocationCoordinate2D(latitude: 61.163624, longitude: 25.947996))
    ]
    private let manage = CLLocationManager()
    
    @State var isNavigationBarHidden: Bool = true
    @State var mapFilters: MKPointOfInterestFilter = MKPointOfInterestFilter(including: [])
    @State private var showDirections = false
    
    @State var tracking : MapUserTrackingMode = .follow
    
    @State private var startPoint = LocationHelper.currentLocation
    
    @State private var city = "no city"
    
    @State var walking: Bool = true
    
    
    var body: some View {
        
        VStack {
            HStack{
                VStack {
                    HStack {
                        Button(action: {
                            manage.desiredAccuracy = kCLLocationAccuracyBest
                            manage.requestWhenInUseAuthorization()
                            manage.startUpdatingHeading()
                            print("startpoint is \($startPoint)")
                            print("LocationHelper.currentLocation is \(LocationHelper.currentLocation)")
                            region = MKCoordinateRegion(center: LocationHelper.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
                            convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
                            print("Tracking user's cityName is \(city)")
                        }, label: {
                            Text("tracking")
                        })
                        
                        Button(action: {
                            convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
                            print("user's location is \(UserDefaults.standard.string(forKey: "city"))")
                            print("user's cityName is \(city)")
                        }, label: {
                            Text("City name")
                        })
                        Text(city)
                        Button(action: {
                            self.walking.toggle()
                        }, label: {
                            Text(walking ? "Walking" : " Automobile")
                        })
                    }
                    .onAppear (){
                        region = MKCoordinateRegion(center: LocationHelper.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
                        convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
                        print("user's cityName is \(city)")
                    }
                    
                }
                
            }
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                //                userTrackingMode: .constant(.follow),
                userTrackingMode: $tracking,
                annotationItems: restaurants)
            { restaurant in
                MapAnnotation(coordinate: restaurant.coordinate) {
                    NavigationLink {
                        DetailsView(restaurant: restaurant)
                    } label:{
                        Image(systemName: "house.circle")
                            .frame(width: 15, height: 15)
                            .onTapGesture {
                                convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
                                print("Tapped on \(restaurant.name)")
                                destination = restaurant.coordinate
                                findDirections()
                                self.showDirections.toggle()
                                print(city)
                            }
                        Text(restaurant.name)
                    }
                }
            }
        }
//        .navigationBarHidden(self.isNavigationBarHidden)
        .navigationBarHidden(true)
        .onAppear(){
            MKMapView.appearance().mapType = .mutedStandard
            MKMapView.appearance().pointOfInterestFilter = .some(mapFilters)
            self.isNavigationBarHidden = true
            convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
            print("onAppear UserDefaults  \(UserDefaults.standard.string(forKey: "city"))")
            print("onAppear cityName \(city)")
            print(LocationHelper.currentLocation)
        }
        .sheet(isPresented: $showDirections, content: {
            VStack(spacing: 0) {
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Divider().background(Color(UIColor.systemBlue))
                
                List(routeSteps) { r in
                    Text(r.step)
                }
                
            }
        })
        
    }
    
    func findDirections(){
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(placemark: MKPlacemark(coordinate: LocationHelper.currentLocation, addressDictionary: nil)))
        
        request.destination = MKMapItem(placemark: MKPlacemark(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil)))
        
        request.requestsAlternateRoutes = false
        
        request.transportType = walking ? .walking : .automobile
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {response, error in
            for route in (response?.routes)! {
                self.routeSteps = [RouteSteps(step: walking ? "By walking" : " By automobile")]
                
                for step in route.steps {
                    self.routeSteps.append(RouteSteps(step: step.instructions))
                }
            }
        })
        
        
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let city = placeMark.locality {
                print(city)
                self.city = city
                UserDefaults.standard.set(city, forKey: "city")
                fetchLocationId(city, context: viewContext)
                print("cityName \(city)")
                
            }
            
            if let street = placeMark.thoroughfare {
                print(street)
          
            }
            
        })
        
    }
    
}


class LocationHelper: NSObject, ObservableObject {
    static let shared = LocationHelper()
    static let DefaultLocation = CLLocationCoordinate2D(latitude: 60.164803, longitude: 24.950328)
    static var currentLocation: CLLocationCoordinate2D {
        guard let location = shared.locationManager.location else {
            return DefaultLocation
        }
        return location.coordinate
    }
    private let locationManager = CLLocationManager()
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(restaurants: RestaurantHC.sampleData)
    }
}
