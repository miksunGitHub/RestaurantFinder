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
    
    init(id: UUID = UUID(), name: String, imageURL: String, rating: Int) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
    }
}

extension Restaurant {
    static let sampleData: [Restaurant] =
    [
        Restaurant(name: "Pago Restaurant", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 4),
        Restaurant(name: "The Owl House", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 3),
        Restaurant(name: "Cella", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 5),
        Restaurant(name: "THE GRILL", imageURL: "https://media-cdn.tripadvisor.com/media/photo-o/15/7a/f4/02/pago-balcony.jpg", rating: 3),
    ]
    
}
