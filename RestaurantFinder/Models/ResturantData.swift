//
//  ApiData.swift
//  RestaurantFinder
//
//  Created by Nischhal on 21.4.2022.
//

import Foundation

struct ApiData: Codable {
    let status: Int
    let msg: String?
    let results: Results
}

struct Results: Codable{
    let data: [Details]
}

struct Details : Codable{
    let name: String
}
