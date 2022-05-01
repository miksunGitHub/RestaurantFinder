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
    
    // Search
    @State private var searchText = ""
    @State private var isEditing = false
    @FetchRequest(
        entity: Restaurant.entity(), sortDescriptors: [])
    var fetchedRestaurants: FetchedResults<Restaurant>
    var searchQuery: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            guard !newValue.isEmpty else {
                fetchedRestaurants.nsPredicate = nil
                return
            }
            fetchedRestaurants.nsPredicate = NSPredicate(
                format: "name contains[cd] %@", newValue)
        }
    }
    
    let restaurants: [RestaurantHC]
    
    @State private var destination = CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)
    
    @State private var point = CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)
    
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.164803, longitude: 24.950328), span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
    
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
                            print("user's location is \(String(describing: UserDefaults.standard.string(forKey: "city")))")
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
                }
            }
            ZStack {
                Map(coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    //                userTrackingMode: .constant(.follow),
                    userTrackingMode: $tracking,
                    annotationItems: fetchedRestaurants)
                { restaurant in
                    MapAnnotation(coordinate: CLLocationCoordinate2DMaker(latitude: Double(restaurant.latitude!)!, longitude: Double(restaurant.longitude!)!)) {
                        
                        let latitude = Double(restaurant.latitude ?? "60.16364")
                        let longitude = Double(restaurant.longitude ?? "24.947996")
                        let newRestaurant = RestaurantHC(
                            name: restaurant.name ?? "no name",
                            imageURL: restaurant.imageurl ?? "no",
                            url: restaurant.url ?? "no url",
                            rating: restaurant.rating,
                            description: restaurant.desc ?? "no descpription",
                            address: restaurant.address ?? "no address",
                            priceLevel: restaurant.price ,
                            coordinate: CLLocationCoordinate2D(
                                latitude: latitude ?? 60.16364,
                                longitude: longitude ?? 24.947996)
                        )
                        
                        RestaurantAnnotation(restaurant: newRestaurant, routeSteps: $routeSteps, showDirections: $showDirections, walking: $walking)
                        /*
                        NavigationLink {
                            DetailsView(restaurant: newRestaurant)
                        } label:{
                            Image(systemName: "house.circle")
                                .foregroundColor(.red)
                                .frame(width: 15, height: 15)
                                .onTapGesture {
                                    print("Tapped on \(String(describing: restaurant.name))")
                                    destination = CLLocationCoordinate2DMaker(latitude: Double(restaurant.latitude!)!, longitude: Double(restaurant.longitude!)!)
                                    findDirections()
                                    self.showDirections.toggle()
                                    print(city)
                                }
                            Text(restaurant.name!)
                            
                        }
                        */
                    }
                }
                VStack {
                    HStack {
                        TextField(NSLocalizedString("search", comment: ""), text: searchQuery)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .shadow(color: .black, radius: 1)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 8)
                                    
                                    if isEditing {
                                        Button(action: {
                                            searchText = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            )
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                isEditing = true
                            }
                        
                        if isEditing {
                            Button(action: {
                                isEditing = false
                                searchText = ""
                                // Dismiss the keyboard
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }) {
                                Text(NSLocalizedString("cancel", comment: ""))
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                    }.padding(.top, 10)
                    
                    if(isEditing) {
                        List {
                            ForEach(fetchedRestaurants) { place in
                                VStack {
                                    Text(place.name ?? "")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                    HStack {
                                        Text(place.address ?? "")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading)
                                        Spacer()
                                        Image(systemName: "location")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                            .onTapGesture {
                                                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(place.latitude!)!, longitude: Double(place.longitude!)!), span: MKCoordinateSpan(latitudeDelta: 0.002,longitudeDelta: 0.002))
                                                isEditing = false
                                            }
                                        
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }.background(isEditing ? Color(.systemGray6) : nil)
            }
        }
        //        .navigationBarHidden(self.isNavigationBarHidden)
        .navigationBarHidden(true)
        .onAppear(){
            MKMapView.appearance().mapType = .mutedStandard
            MKMapView.appearance().pointOfInterestFilter = .some(mapFilters)
            self.isNavigationBarHidden = true
            convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
            print("onAppear UserDefaults  \(String(describing: UserDefaults.standard.string(forKey: "city")))")
            print("onAppear cityName \(city)")
            print(LocationHelper.currentLocation)
        }
        .sheet(isPresented: $showDirections, content: {
            VStack(spacing: 0) {
                Text("Directions \(walking ? " by walking" : " by automobile")")
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
    
    func CLLocationCoordinate2DMaker(latitude: Double, longitude: Double) -> CLLocationCoordinate2D{
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return location
    }
    
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let city = placeMark.locality {
                print(city)
                
                if self.city == city || UserDefaults.standard.string(forKey: "city") == city {
                    return
                } else {
                    fetchLocationId(city, context: viewContext)
                }
                self.city = city
                UserDefaults.standard.set(city, forKey: "city")
            }
        })
        
    }
    
}

extension CLLocationCoordinate2D {
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
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
