//
//  ResturantApi.swift
//  RestaurantFinder
//
//  Created by Nischhal on 24.4.2022.
//

import Foundation
import SwiftUI
import CoreData

// Fetching resurant data from  Api
func fetchData (_ location_id: String, context: NSManagedObjectContext){
    
    let moc = context
    //@Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Restaurant.entity(), sortDescriptors: []) var restaurants: FetchedResults<Restaurant>
    
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
        
        do{
            
            let jsonObject = try JSONDecoder().decode(ApiData.self, from: data!)
            
            jsonObject.results.data.forEach{restaurant in
                //print(String(resturant.photo?.images?.medium?.url ?? "none") )
                
                print(restaurant.latitude ?? "60.163624")
                print(restaurant.longitude ?? "24.947996")
            
                
            }
            
            jsonObject.results.data.forEach{ item in
                //let restarant = Restarant(context: moc)
                //restarant.name = item.name
                
                let newRestaurant = Restaurant(context: moc)
                newRestaurant.name = String(item.name ?? "no name")
                newRestaurant.url = String(item.photo?.images?.medium?.url ?? "https://via.placeholder.com/150/208aa3/208aa3?Text=RestaurantFinder")
                newRestaurant.address = String(item.address_obj?.street1 ?? "no address")
                newRestaurant.desc = String(item.description ?? "no description")
                newRestaurant.rating = Int64(item.rating ?? "1") ?? 1
                newRestaurant.price = Int64(5)
                newRestaurant.latitude = item.latitude
                newRestaurant.longitude = item.longitude
                    //print(newRestaurant)
                    
                    do {
                        try moc.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                
            }

            //try? moc.save()
        
        catch{
            print("Error printing \(error)")
        }
        
    })
    
    dataTask.resume()
}
