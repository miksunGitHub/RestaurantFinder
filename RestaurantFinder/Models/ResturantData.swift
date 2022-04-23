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
    let data: [Resturant]
}

struct Resturant : Codable{
    let location_id: String
    let name:String
    let latitude: String
    let longitude:String
    let num_reviews:String
    let timezone :String
    let ranking: String
    let rating: String
    let description: String
    let web_url: String
    let write_review: String
    let address_obj: Address
    //    let hours
    //    let cuisine
    //    let dietary_restrictions
    
}

struct Address: Codable{
    let street1: String?
    let street2 : String?
    let city : String?
    let state : String?
    let country : String?
    let postalcode : String?

}
