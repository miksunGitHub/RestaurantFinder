
//  HomeView.swift
//  RestaurantFinder
//  - INSERT CLASS COMMENT -
//
//  Created by Alex on 11.4.2022.
//

import SwiftUI
import MapKit
import CoreLocation

// For creating steps of a route to a destination
struct RouteSteps: Identifiable {
    let id = UUID()
    let step : String
}

struct HomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Restaurant.entity(), sortDescriptors: [])
    var fetchedRestaurants: FetchedResults<Restaurant>
    
    // Search Query using Predicates
    @State private var isEditing = false // if searchbar is being edited
    @State private var searchText = ""
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
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 60.164803, longitude: 24.950328),
        span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
    @State var routeSteps : [RouteSteps] = []
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
            ZStack {
                // initiate the map view
                Map(coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking,
                    annotationItems: fetchedRestaurants)
                { restaurant in
                    MapAnnotation(coordinate: CLLocationCoordinate2DMaker(latitude: Double(restaurant.latitude ?? "60.16364")!, longitude: Double(restaurant.longitude ?? "24.947996")!)) {
                        
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
                                longitude: longitude ?? 24.947996),
                            city: restaurant.city ?? "no city",
                            email: restaurant.email ?? "no email" ,
                            phone: restaurant.phone ?? "no phone" ,
                            ranking: restaurant.ranking ?? "no ranking"
                        )
                        
                        // Creating map annotations from restaurant entities
                        RestaurantAnnotation(restaurant: newRestaurant, routeSteps: $routeSteps, showDirections: $showDirections, walking: $walking)
                    }
                }
                
                VStack {
                    HStack { // Searchbar
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
                    
                    if(isEditing) { // Search results
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
                    if(!isEditing) { // Button to locate user
                        Button(action:{
                            region = MKCoordinateRegion(center: LocationHelper.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
                            convertLatLongToAddress(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude)
                        }) {
                                Label("", systemImage: "location.circle")
                                .font(.system(size: 30.0))
                            }
                        .offset(x: 140)
                        .padding(.bottom, 20)
                    }
                }.background(isEditing ? Color(.systemGray6) : nil)
            }
        }
        .navigationBarHidden(true)
        .onAppear(){
            // mute the map to make tha annotations on the map more conspicuous
            MKMapView.appearance().mapType = .mutedStandard
            // filter out other default point of interests on the map
            MKMapView.appearance().pointOfInterestFilter = .some(mapFilters)
            self.isNavigationBarHidden = true
            //convert the user's coordination to city name and make api call
            convertLatLongToAddress(
                latitude: LocationHelper.currentLocation.latitude,
                longitude: LocationHelper.currentLocation.longitude)
        }
        // if showDirections is true show Directions to selected destination (restaurant) by sheet
        .sheet(isPresented: $showDirections, content: {
            VStack(spacing: 0) {
                Text(
                    NSLocalizedString("directions", comment: "")
                    + (walking ? NSLocalizedString("walking", comment: "") : NSLocalizedString("byCar", comment: ""))
                )
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
    // Translate the latitude and longitude to CLLocationCoordinate2D data type
    func CLLocationCoordinate2DMaker(latitude: Double, longitude: Double) -> CLLocationCoordinate2D{
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return location
    }
    
    // Convert coordinator to a real address
    func convertLatLongToAddress(latitude:Double,longitude:Double){
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: latitude, longitude: longitude)
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        
        var placeMark: CLPlacemark!
        placeMark = placemarks?[0]
        
        if let city = placeMark.locality {
            // make the api call in the first time opening the app and when user's located city has changed
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

// Add distance calculation function to CLLocationCoordinate2D protocol
extension CLLocationCoordinate2D {
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }
}

// For getting the coordinates of user's current location
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
        HomeView()
    }
}
