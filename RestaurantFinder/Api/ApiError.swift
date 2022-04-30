//
//  ApiError.swift
//  RestaurantFinder
//
//  Created by Nischhal on 30.4.2022.
//

import Foundation

// Error handler
enum APIError: Error, CustomStringConvertible{
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizeDescription: String{
        // user feedback
        switch self {
        case .badURL, .parsing , .unknown:
            return "Sorry something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
    
    var description: String{
        // info for debugging
        switch self {
        case .badURL:
            return "Invalid URL."
        case .badResponse(let statusCode):
            return "Bad response with status code\(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "URL session error."
        case .parsing(let error):
            return "Parsing error \(error?.localizedDescription ?? "")"
        case .unknown:
            return "Unknow error"
        }
    }
}
