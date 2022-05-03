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
    let location_id: String?
    let name:String?
    let latitude: String?
    let longitude:String?
    let num_reviews:String?
    let timezone :String?
    let ranking: String?
    let rating: String?
    let description: String?
    let web_url: String?
    let write_review: String?
    let address_obj: Address?
    let phone: String?
    let website : String?
    let email : String?
    let booking: Booking?
    let cuisine: [CusineType]?
    let dietary_restrictions: [CusineType]?
    let photo: ImagesObject?
}

struct Address: Codable{
    let street1: String?
    let street2 : String?
    let city : String?
    let state : String?
    let country : String?
    let postalcode : String?
}

struct ImagesObject: Codable{
    let images: Images?
}

struct Images: Codable {
    let small: ImageObject?
    let medium: ImageObject?
    let original: ImageObject?
}

struct ImageObject : Codable {
    let width: String?
    let url: String?
    let height: String?
}

struct CusineType: Codable{
    let key: String?
    let name: String?
}

struct Booking: Codable{
    let url: String?
}
