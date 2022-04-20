//
//  DetailsView.swift
//  RestaurantFinder
//
//  Created by iosdev on 13.4.2022.
//

import SwiftUI
import Foundation

struct DetailsView: View {
    let restaurant: Restaurant
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack{
                AsyncImage(url: URL(string: restaurant.imageURL),
                           content: {
                    image in image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 270, maxHeight: 180)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange, lineWidth: 2))
                        .shadow(radius: 10)
                },
                           placeholder: {
                    ProgressView()
                })
                Text(restaurant.name).padding()
                HStack{
                    Text("Rating: ")
                    ForEach(0..<restaurant.rating){ i in
                        Image(systemName: "star.fill").resizable().frame(width: 10, height: 10)
                    }
                }
                Link("Website", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
                Spacer()
                Button(action: {fetchData()}, label: {
                    Text("Click")
                })
                
            }
        })
    }
    
    // Sample test
    //        func parse (){
    //            let url = URL(string: "https://api.androidhive.info/contacts/")
    //            guard url != nil else{
    //                print("Error creating url object")
    //                return
    //            }
    //
    //            URLSession.shared.dataTask(with: (url as URL?)! , completionHandler: { (data, response, error) -> Void in
    //                if error != nil{
    //                    print(error!.localizedDescription)
    //                    return
    //                }
    //                    print("Data",data!)
    //                do{
    //                    let result = try JSONDecoder().decode(Welcome.self, from: data!)
    //                    print("Result",result)
    //
    //                }catch{}
    //            }).resume()
    //        }
    func fetchData (){
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
            "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
        ]
        
        let postData = NSMutableData(data: "language=en_US".data(using: String.Encoding.utf8)!)
        postData.append("&limit=50".data(using: String.Encoding.utf8)!)
        postData.append("&location_id=189932".data(using: String.Encoding.utf8)!)
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
            
//            do{
//                let dictinary = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers)
//                as? [String:Any]
//                let t = type(of: dictinary)
//                print("type",t)
//                print("Dicionary",dictinary)
//
//            }
//            catch{
//                print("Error printing")
//            }
            let stringData = String(data: data!, encoding: .utf8)
//             print("data \(stringData)")
            do{
                
                let jsonObject = try JSONDecoder().decode(ApiData.self, from: data!)
                print("Data \(jsonObject)")
            }
            catch{
                print("Error printing")
            }
            
        })
        
        dataTask.resume()
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var restaurant = Restaurant.sampleData[0]
    
    static var previews: some View {
        DetailsView(restaurant: restaurant)
    }
}
