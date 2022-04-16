//
//  Restaurant.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 12.4.2022.
//

import Foundation

struct Restaurant: Identifiable {
    let id: UUID
    var name: String
    var imageURL: String
    var rating: Int
    var description: String
    var address: String
    
    init(id: UUID = UUID(), name: String, imageURL: String, rating: Int, description: String, address: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.description = description
        self.address = address
    }
}

extension Restaurant {
    static let sampleData: [Restaurant] =
    [
        Restaurant(name: "Pago Restaurant", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 4, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo"),
        Restaurant(name: "The Owl House", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo"),
        Restaurant(name: "Cella", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 5, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo"),
        Restaurant(name: "THE GRILL", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 3, description: "Pago Restaurant is a new dining experience concept serving authentic Indonesian, Asian and Western specialties. Open for breakfast, lunch, and dinner, this restaurant offers extensive buffet and a la carte options.", address: "Ulappakatu 3, Espoo"),
    ]
    
}
