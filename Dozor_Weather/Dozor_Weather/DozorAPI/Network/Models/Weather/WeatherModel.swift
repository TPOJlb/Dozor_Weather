//
//  WeatherModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

public struct WeatherModel: Codable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [List?]?
    var city: City?
}

public struct List: Codable {
    var dt: Int?
    var main: Main?
    var weather: [Weather?]?
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var sys: Sys?
    var dt_txt: String?
}

public struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Cord?
    var country: String?
    var population: Int?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
}

public struct Cord: Codable {
    var lat: Double?
    var lon: Double?
}

public struct Main: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int?
    var temp_kf: Double?
}

public struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: IconsModel?
}

public struct Clouds: Codable {
    var all: Int?
}

public struct Wind: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}

public struct Sys: Codable {
    var pod: String?
}
