//
//  DetailsView.swift
//  RestaurantFinder
//
//  Created by iosdev on 13.4.2022.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    let restaurant: RestaurantInfo
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        ScrollView {
            VStack {
                Map(coordinateRegion: $region)
                    .ignoresSafeArea(edges: .top)
                    .colorScheme(ColorScheme.dark)
                    .frame(height: 300)
                    .onAppear() {
                        
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: restaurant.coordinate.latitude, longitude: restaurant.coordinate.longitude),
                            span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                        )
                    }
                
                AsyncImage(url: URL(string: restaurant.imageURL),
                           content: {
                    image in image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                        .offset(y: -130)
                        .padding(.bottom, -130)
                },
                           placeholder: {
                    ProgressView()
                })
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        ForEach(0..<Int(restaurant.rating)){ i in
                            Image(systemName: "star.fill").resizable().frame(width: 10, height: 10)
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(restaurant.ranking)
                            .font(.subheadline)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    HStack {
                        Text(restaurant.name)
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .font(.title)
                    VStack {
                        HStack {
                            Text(restaurant.address)
                            Spacer()
                            Text(restaurant.city)
                        }
                        
                        HStack {
                            Text(restaurant.phone)
                            Spacer()
                        }
                        
                        HStack {
                            Text(restaurant.email)
                            Spacer()
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    
                    
                    Divider()
                    
                    Text(NSLocalizedString("about", comment: ""))
                        .font(.title2)
                        .foregroundColor(Color.white)
                    Text(restaurant.description)
                        .foregroundColor(Color.white)
                    Link(NSLocalizedString("website", comment: ""), destination: URL(string: restaurant.url)!).font(.custom(FontsName.EBGaraRomanSemiBold.rawValue, size: 20))
                        .padding(.top, 15)
                }
                .padding()
                
                Spacer()
            }
        }.background(Color.colorDarkGrey)
    }
    //      Printing fonts: To be deleted later
    //    func getFonts(){
    //        UIFont.familyNames.forEach({ name in
    //            for font_name in UIFont.fontNames(forFamilyName: name){
    //                print("\n\(font_name)")
    //            }
    //        })
    //    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var restaurant = RestaurantInfo.sampleData[0]
    
    static var previews: some View {
        DetailsView(restaurant: restaurant)
    }
}
