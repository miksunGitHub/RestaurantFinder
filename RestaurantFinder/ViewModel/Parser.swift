//
//  Parser.swift
//  RestaurantFinder
//
//  Created by Nischhal on 17.4.2022.
//

import Foundation

struct Parser {
    func parse (){
        let api = URL(string: "https://api.androidhive.info/contacts/")
        URLSession.shared.dataTask(with: (api as URL?)! , completionHandler: { (data, response, error) -> Void in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(Welcome.self, from: data!)
                print("Result",result)
                
            }catch{}
        }).resume()
    }
}
