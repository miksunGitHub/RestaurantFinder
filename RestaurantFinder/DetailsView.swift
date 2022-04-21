//
//  DetailsView.swift
//  RestaurantFinder
//
//  Created by iosdev on 13.4.2022.
//

import SwiftUI

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
                // Button("Click", action: {getFonts()})
                Text(restaurant.name).font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 30)).foregroundColor(.colorBrown)
                VStack(alignment: .leading){
                    HStack{
                        Text("Rating: ").font(.custom(FontsName.EBGaraRomanMedium.rawValue, size: 20)).foregroundColor(.colorDarkPurple)
                        ForEach(0..<restaurant.rating){ i in
                            Image(systemName: "star.fill").resizable().frame(width: 10, height: 10)
                        }
                    }
                    Link("Website", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!).font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 20))
                    Text("Description:").font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 20)).padding([.top],1).foregroundColor(.colorDarkPurple)
                    Text(restaurant.description).font(.custom(FontsName.EBGaraRomanMedium.rawValue, size: 20)).padding([.top],0.5).foregroundColor(.colorDarkPurple)
                    Text("Address:\(restaurant.address)").font(.custom(FontsName.EBGaraRomanMedium.rawValue, size: 20)).padding(.top).foregroundColor(.colorDarkPurple)
                    Button(action: {fetchData()}, label: {
                        Text("Click")
                    })
                }
            }
        })
    }
//      Printing fonts: To be deleted later
//    func getFonts(){
//        UIFont.familyNames.forEach({ name in
//            for font_name in UIFont.fontNames(forFamilyName: name){
//                print("\n\(font_name)")
//            }
//        })
//    }
    
    // Fetching data from Api
    func fetchData (){
            
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "X-RapidAPI-Host": "worldwide-restaurants.p.rapidapi.com",
                "X-RapidAPI-Key": "60b315c809msh733da161b5bb9e9p1619b1jsn9a09d2994c39"
            ]
            
            let postData = NSMutableData(data: "language=en_US".data(using: String.Encoding.utf8)!)
            postData.append("&limit=100".data(using: String.Encoding.utf8)!)
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
                
                // printing data as string
                //            let stringData = String(data: data!, encoding: .utf8)
                //             print("data \(stringData)")
                do{
                    
                    let jsonObject = try JSONDecoder().decode(ApiData.self, from: data!)
//                    print("Data \(jsonObject.results.data.count)")
                    print("Data \(jsonObject.results)")
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
