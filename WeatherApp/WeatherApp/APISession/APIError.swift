//
//  APIError.swift
//  WeatherApp
//
//  Created by pooja  on 14/07/21.
//

import Foundation

enum ApiError: Error {
    
    case invalidURL
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case internetConnectivityFailure
    case internalServerError
    case tokenExpired
    case dataNotFound
    case custom(error: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .internetConnectivityFailure: return "Please Check Your Internet Connectivity"
        case .dataNotFound: return "Data Not Found"
        case .internalServerError: return "Internal Server Error"
        case .tokenExpired: return "Token expired"
        case .custom(error: let error): return  error
        }
    }
    
}
