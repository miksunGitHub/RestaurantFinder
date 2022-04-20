//
//  Data.swift
//  RestaurantFinder
//
//  Created by Nischhal on 19.4.2022.
//

import Foundation

import SwiftUI

struct ApiData: Codable {
    let status: Int
    let msg: String?
    let results: Results
}

struct Results: Codable{
    let data: [Test]
}

struct Test : Codable{
    let name: String
}

