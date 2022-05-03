//
//  ResturantApi.swift
//  RestaurantFinder
//
//  Created by Nischhal on 24.4.2022.
//

import Foundation
import SwiftUI
import CoreData

/**
 *  Fetching resurant data from  Api
 *  Location id and context as parameter
 *  Fetches resturants data through location id
 *  Decodes Api response using json decoder
 *  Finally stores decoded data in core-data
 */
func fetchData (_ location_id: String, context: NSManagedObjectContext){
    let moc = context
    @FetchRequest(
        entity: Restaurant.entity(), sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
        "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
    ]
    let postData = NSMutableData(data: "language=en_US".data(using: String.Encoding.utf8)!)
    postData.append("&limit=100".data(using: String.Encoding.utf8)!)
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
        
        do{
            // Decoding api data
            let jsonObject = try JSONDecoder().decode(ApiData.self, from: data!)
            
            // Deleting Core-Data data
            let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
            do {
                let data = try context.fetch(fetchRequest)
                if data.count > 0 {
                    try batchDelete(in: context, fetchRequest: fetchRequest)
                }
            } catch {
                print("Error deleting core-data")
            }
            
            // Storing data in core-data for json array
            jsonObject.results.data.forEach{ item in
                
                let newRestaurant = Restaurant(context: moc)
                newRestaurant.name = String(item.name ?? "no name")
                newRestaurant.imageurl = String(item.photo?.images?.medium?.url ?? "https://via.placeholder.com/150/208aa3/208aa3?Text=RestaurantFinder")
                newRestaurant.url = item.website
                newRestaurant.address = String(item.address_obj?.street1 ?? "no address")
                newRestaurant.desc = String(item.description ?? "no description")
                newRestaurant.rating = Double(item.rating ?? "1.0") ?? 1.0
                newRestaurant.price = Int64(5)
                newRestaurant.latitude = item.latitude
                newRestaurant.longitude = item.longitude
                newRestaurant.postalcode = item.address_obj?.postalcode ?? "Postal code not found"
                newRestaurant.city = String(item.address_obj?.city ?? "no city")
                newRestaurant.email = item.email
                newRestaurant.phone = item.phone
                newRestaurant.ranking = item.ranking
                
                // Saves data
                do {
                    try moc.save()
                } catch {
                    let nsError = error as NSError
                    print("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            
        }
        catch{
            print("Error printing \(error)")
        }
    })
    
    dataTask.resume()
}
