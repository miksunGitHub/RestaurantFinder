//
//  LocationApi.swift
//  RestaurantFinder
//
//  Created by Nischhal on 24.4.2022.
//

import Foundation
import SwiftUI
import CoreData

/**
 *   Fetching location id through location name
 *   Takes location and context as paramet
 */
func fetchLocationId(_ location: String, context: NSManagedObjectContext){
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
        "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
    ]
    
    // hardcode location(Needs to be taken from input)
    let postData = NSMutableData(data: "q=\(location)".data(using: String.Encoding.utf8)!)
    postData.append("&language=en_US".data(using: String.Encoding.utf8)!)
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://worldwide-restaurants.p.rapidapi.com/typeahead")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData as Data
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if error != nil{
            print(error!.localizedDescription)
            return
        }
        
        do{
            // Decoding Api data
            let jsonObject = try JSONDecoder().decode(LocationData.self, from: data!)
            // Stores the value of location id
            let location_id = jsonObject.results.data[0].result_object.location_id
            // Passing location id as parameter to fetch resturant data of that specific location
            fetchData(location_id, context: context)
        }
        catch{
            print("Error printing \(type(of: location))")
        }
    })
    dataTask.resume()
}
