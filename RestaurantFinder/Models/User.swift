//
//  User.swift
//  RestaurantFinder
//
//  Created by Nischhal on 17.4.2022.
//

import Foundation

struct Welcome: Codable{
    let contacts: [Contact]
}

struct Contact: Codable{
    let id, name , email: String
}
