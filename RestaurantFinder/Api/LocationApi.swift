//
//  LocationApi.swift
//  RestaurantFinder
//
//  Created by Nischhal on 24.4.2022.
//

import Foundation
import SwiftUI
import CoreData


// Fetching location id from location name
struct LocationApi {
    
    func fetchLocationId(_ headers: [String: String],_ location: String, completion: @escaping (Result <LocationData, APIError> ) -> Void){
        //        guard let url = URL(string: "https://worldwide-restaurants.p.rapidapi.com/typeahead") else {
        //            let error = APIError.badURL
        //            completion(Result.failure(error))
        //            return
        //        }
        
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
            
            if let error = error as? URLError{
                completion(Result.failure(APIError.url(error)))
            }else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                do{
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    //                    print("Data \(locationData)")
                    completion(Result.success(locationData))
                    
                }
                catch{
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
            
        })
        dataTask.resume()
    }
}
