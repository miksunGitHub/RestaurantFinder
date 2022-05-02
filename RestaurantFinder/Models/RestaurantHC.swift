//
//  Restaurant.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 12.4.2022.
//

import Foundation
import CoreLocation

struct RestaurantHC: Identifiable {
    let id: UUID
    var name: String
    var imageURL: String
    var url: String
    var rating: Double
    var description: String
    var address: String
    var priceLevel: Int64
    var coordinate: CLLocationCoordinate2D
    var city: String
    var email: String
    var phone: String
    var ranking: String
    
    
    init(id: UUID = UUID(), name: String, imageURL: String, url: String, rating: Double, description: String, address: String, priceLevel: Int64, coordinate: CLLocationCoordinate2D, city: String, email: String, phone: String, ranking: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.url = url
        self.rating = rating
        self.description = description
        self.address = address
        self.priceLevel = priceLevel
        self.coordinate = coordinate
        self.city = city
        self.email = email
        self.phone = phone
        self.ranking = ranking
    }
}

extension RestaurantHC {
    static let sampleData: [RestaurantHC] =
    [
        RestaurantHC(name: "Baskeri & Basso", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/0f/bf/92/0c/salmon-carpaccio.jpg", url: "https://basbas.fi/",  rating: 4, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 4, coordinate: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328), city: "Helsinki", email: "bas@bas.fi", phone: "0504673400", ranking: "no ranking"),
        /*RestaurantHC(name: "Toca", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/1b/04/69/91/beef.jpg", url: "https://www.toca.fi/",  rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 3, coordinate: CLLocationCoordinate2D(latitude: 60.1655, longitude: 24.951344)),
        RestaurantHC(name: "Finlandia Caviar", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/1d/d1/01/4e/caviar-and-oysters.jpg", url: "https://www.finlandiacaviar.fi/",  rating: 5, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 2, coordinate: CLLocationCoordinate2D(latitude: 60.16717, longitude: 24.952295)),
        RestaurantHC(name: "Spis",  imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/13/44/01/be/photo9jpg.jpg", url: "https://spis.fi/", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 3, coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996)),*/
    ]
    
}
