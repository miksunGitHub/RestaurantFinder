//
//  Resturant.swift
//  RestaurantFinder
//
//  Created by Nischhal on 17.4.2022.
//

import Foundation

struct Resturants: Codable{
    let detail: [Detail]
}
struct Detail: Codable{
    let name: String
}
