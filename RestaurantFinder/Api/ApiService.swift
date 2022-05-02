//
//  ApiService.swift
//  RestaurantFinder
//
//  Created by Nischhal on 30.4.2022.
//

import Foundation
import SwiftUI
class ApiService: ObservableObject {
//    @Environment(\.managedObjectContext) private var viewContext
    @Published var location: String = "Helsinki"
//    @Binding var location: String
    @Published var errorMessage: String? = nil
    @Published var resturants = [Resturant]()
    
    let headers = [
        "content-type": "application/x-www-form-urlencoded",
        "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
        "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
    ]
    
    init(){
        locationService(self.location)
    }
    
    // Creating instance of LocationApi and Fetching value on success
    func locationService(_ location: String?){
        let service = LocationApi()
        // Assigning newly changed location
        self.location = location!
        service.fetchLocationId(headers, self.location){[unowned self] result in
            DispatchQueue.main.async { [self] in
                switch result{
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let locationData):
                    let location_id = locationData.results.data[0].result_object.location_id
//                    print("From class", self.location_id!)
                    resturantService(location_id)
                }
            }
            
        }
    }
    
    // Creating instance of ResturantApi and Fetching value on success
    func resturantService(_ location_id: String){
        let service = ResturantApi()
        service.fetchResturants(headers, location_id){[unowned self] result in
            DispatchQueue.main.async { [self] in
                switch result{
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .success(let resturants):
                    self.resturants = resturants.results.data
                    self.resturants.forEach{resturant in
                        print(resturant.name!)
                    }
                    addRestuarntToCoreData(self.resturants)
                }
            }
           
        }
    }
    
    // Adding resturants to core data
    func addRestuarntToCoreData(_ resturants: [Resturant]){
       let coreData = CoreDataViewModel()
        coreData.addResturants(resturants)
    }
}
