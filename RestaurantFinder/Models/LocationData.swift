//
//  LocationData.swift
//  RestaurantFinder
//
//  Created by Nischhal on 21.4.2022.
//

import Foundation

struct LocationData: Codable {
    let status: Int
    let msg: String?
    let results: LocationResults
}

struct LocationResults: Codable{
    let data: [LocationDetails]
}

struct LocationDetails : Codable{
    let result_object: LocationObject
}

struct LocationObject: Codable{
    let location_id: String
    let name: String
}
