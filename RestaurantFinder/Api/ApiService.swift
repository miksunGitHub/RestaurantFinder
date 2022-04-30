//
//  ApiService.swift
//  RestaurantFinder
//
//  Created by Nischhal on 30.4.2022.
//

import Foundation
import SwiftUI
class ApiService :ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    @Published var location: String = UserDefaults.standard.string(forKey: "city")!
    @Published var location_id: String? = nil
    @Published var errorMessage: String? = nil
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
        "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
    ]
    
    init(){
        locationService()
//        fetchLocationId(UserDefaults.standard.string(forKey: "city")!, context: viewContext, headers)
    }
    
    // Craeting instance of LocationApi and Fetching value on success
    func locationService(){
        let service = LocationApi()
        service.fetchLocationId(headers, location){[unowned self] result in
            DispatchQueue.main.async {
                switch result{
                case.failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let locationData):
                    self.location_id = locationData.results.data[0].result_object.location_id
                    print("From class", self.location_id!)
                }
            }
        }
    }

}
