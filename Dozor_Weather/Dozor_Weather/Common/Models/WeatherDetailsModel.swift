//
//  WeatherDetailsModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import Foundation
import UIKit.UIImage

enum WeatherDetailsTypes {
    case wind
    case humidity
    case chanceOfRain
    case tempMax
    case tempMin
    case pressure
    
    var image: UIImage {
        switch self {
        case .wind:
            return .iconWind
        case .humidity:
            return .iconHumidity
        case .chanceOfRain:
            return .iconChanceOfRain
        case .tempMax:
            return .iconTempMax
        case .tempMin:
            return .iconTempMin
        case .pressure:
            return .iconPressure
        }
    }
    
    var title: String {
        typealias localize = String.Main.WeatherDetails
        
        switch self {
        case .wind:
            return localize.wind
        case .humidity:
            return localize.humidity
        case .chanceOfRain:
            return localize.chanceOfRain
        case .tempMax:
            return localize.tempMax
        case .tempMin:
            return localize.tempMin
        case .pressure:
            return localize.pressure
        }
    }
}

struct WeatherDetailsModel {
    let type: WeatherDetailsTypes
    let title: String?
}
