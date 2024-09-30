//
//  DozorAPI.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

public final class DozorAPI: NSObject {
    public static let weatherManager    = WeatherManager()
    public static let locationManager   = LocationManager()
    public static let citiesManager     = CitiesManager()
}
