//
//  WeatherService.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation
import UIKit

internal class WeatherService {
    
    private let api = NetworkHelper()
    
    func getWeatherFiveDays(latitude: Double,
                            longitude: Double,
                            success: @escaping (WeatherModel) -> Void,
                            failure: @escaping (Error) -> Void) {
        let params: [String: Any] = [
            "lat":      latitude,
            "lon":      longitude,
            "appid":    Constants.APIKey,
            "units":    "metric",
            "lang":     "en"
        ]
        api.get(apiRoute: .fiveDays, params: params, success: { (model: WeatherModel) in
            success(model)
        }, failure: { error in
            failure(error)
        })
        
    }
}
