//
//  APIConstants.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

public struct APIConstants {
    enum APIRoutes {
        // weather
        case fiveDays
        // location
        case location
        
        var urlString: String {
            switch self {
                // weather
            case .fiveDays:
                return "/data/2.5/forecast"
                // location
            case .location:
                return "/json"
            }
        }
        
        
        var domain: String {
            switch self {
                // weather
            case .fiveDays:
                return "https://api.openweathermap.org"
                // location
            case .location:
                return "https://ipinfo.io"
            }
        }
    }
    
}
