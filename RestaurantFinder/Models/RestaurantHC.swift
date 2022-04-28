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
    var rating: Double
    var description: String
    var address: String
    var priceLevel: Int64
    var coordinate: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), name: String, imageURL: String, rating: Double, description: String, address: String, priceLevel: Int64, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.description = description
        self.address = address
        self.priceLevel = priceLevel
        self.coordinate = coordinate
    }
}

extension RestaurantHC {
    static let sampleData: [RestaurantHC] =
    [
        RestaurantHC(name: "Baskeri & Basso", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/0f/bf/92/0c/salmon-carpaccio.jpg", rating: 4, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 4, coordinate: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)),
        RestaurantHC(name: "Toca", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/1b/04/69/91/beef.jpg", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 3, coordinate: CLLocationCoordinate2D(latitude: 60.1655, longitude: 24.951344)),
        RestaurantHC(name: "Finlandia Caviar", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/1d/d1/01/4e/caviar-and-oysters.jpg", rating: 5, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 2, coordinate: CLLocationCoordinate2D(latitude: 60.16717, longitude: 24.952295)),
        RestaurantHC(name: "Spis", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/13/44/01/be/photo9jpg.jpg", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 3, coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996)),
    ]
    
}
