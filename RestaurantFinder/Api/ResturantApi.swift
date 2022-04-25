//
//  ResturantApi.swift
//  RestaurantFinder
//
//  Created by Nischhal on 24.4.2022.
//

import Foundation
import SwiftUI

// Fetching resurant data from  Api
func fetchData (_ location_id: String){
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
        "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
    ]
    let postData = NSMutableData(data: "language=en_US".data(using: String.Encoding.utf8)!)
    postData.append("&limit=100".data(using: String.Encoding.utf8)!)
    // hard coded location id(needs to be taken from fetchlocation function)
    postData.append("&location_id=\(location_id)".data(using: String.Encoding.utf8)!)
    postData.append("&currency=USD".data(using: String.Encoding.utf8)!)
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://worldwide-restaurants.p.rapidapi.com/search")! as URL,
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
        
        // printing data as string
        //            let stringData = String(data: data!, encoding: .utf8)
        //             print("data \(stringData)")
        do{
            
            let jsonObject = try JSONDecoder().decode(ApiData.self, from: data!)
            
            // print("Data \(jsonObject.results)")
            jsonObject.results.data.forEach{resturant in
//                    print(resturant)
                print(resturant)
            }
//                jsonObject.results.data.forEach{ item in
//                    let resturant = ResturantObject(context: moc)
//                    resturant.name = item.name
//                    resturant.origin = ResturantArray(context: moc)
//                }
//
//                try? moc.save()
        }
        catch{
            print("Error printing")
        }
        
    })
    
    dataTask.resume()
}
