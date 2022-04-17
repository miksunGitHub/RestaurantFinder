//
//  Restaurant.swift
//  RestaurantFinder
//
//  Created by Mikko Suhonen on 12.4.2022.
//

import Foundation
import CoreLocation

struct Restaurant: Identifiable {
    let id: UUID
    var name: String
    var imageURL: String
    var rating: Int
    var location_id: Int
    var coordinate: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), name: String, imageURL: String, rating: Int, location_id: Int, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.rating = rating
        self.location_id = location_id
        self.coordinate = coordinate
    }
}

extension Restaurant {
    static let sampleData: [Restaurant] =
    [
        Restaurant(name: "Baskeri & Basso", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/0f/bf/92/0c/salmon-carpaccio.jpg", rating: 4, location_id: 9738731, coordinate: CLLocationCoordinate2D(latitude: 60.157803, longitude: 24.934328)),
        Restaurant(name: "Toca", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/1b/04/69/91/beef.jpg", rating: 3, location_id: 14761297, coordinate: CLLocationCoordinate2D(latitude: 60.1655, longitude: 24.951344)),
        Restaurant(name: "Finlandia Caviar", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/1d/d1/01/4e/caviar-and-oysters.jpg", rating: 5, location_id: 7346196, coordinate: CLLocationCoordinate2D(latitude: 60.16717, longitude: 24.952295)),
        Restaurant(name: "Spis", imageURL: "https://media-cdn.tripadvisor.com/media/photo-l/13/44/01/be/photo9jpg.jpg", rating: 3, location_id: 2569524, coordinate: CLLocationCoordinate2D(latitude: 60.163624, longitude: 24.947996)),
    ]
    
}
