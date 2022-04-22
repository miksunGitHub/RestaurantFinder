//
//  Restaurant.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 12.4.2022.
//

import Foundation

struct RestaurantHC: Identifiable {
    let id: UUID
    var name: String
    var imageURL: String
    var rating: Int64
    var description: String
    var address: String
    var priceLevel: Int64
    
    init(id: UUID = UUID(), name: String, imageURL: String, rating: Int64, description: String, address: String, priceLevel: Int64) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.description = description
        self.address = address
        self.priceLevel = priceLevel
    }
}

extension RestaurantHC {
    static let sampleData: [RestaurantHC] =
    [
        RestaurantHC(name: "Pago Restaurant", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 4, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 4),
        RestaurantHC(name: "The Owl House", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 3),
        RestaurantHC(name: "Cella", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 5, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 2),
        RestaurantHC(name: "THE GRILL", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo", priceLevel: 3),
    ]
    
}
