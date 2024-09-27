//
//  WeatherManager.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

public class WeatherManager {
    
    private let weatherService = WeatherService()
    
    public func getWeatherFiveDays(latitude: Double,
                           longitude: Double,
                           success: @escaping (WeatherModel) -> Void,
                           failure: @escaping (Error) -> Void) {
        weatherService.getWeatherFiveDays(latitude: latitude, longitude: longitude) { res in
            success(res)
        } failure: { error in
            failure(error)
        }
    }
}
