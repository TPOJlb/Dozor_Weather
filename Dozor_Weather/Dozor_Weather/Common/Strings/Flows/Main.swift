//
//  Main.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

extension String {
    struct Main {
        private init() {}
        //MARK: - WeatherDetails
        struct WeatherDetails {
            private init() {}
            static let wind = "weather_details_wind".localized()
            static let humidity = "weather_details_humidity".localized()
            static let chanceOfRain = "weather_details_chance_of_rain".localized()
            static let tempMax = "weather_details_temp_max".localized()
            static let tempMin = "weather_details_temp_min".localized()
            static let pressure = "weather_details_pressure".localized()
        }
    }
}
