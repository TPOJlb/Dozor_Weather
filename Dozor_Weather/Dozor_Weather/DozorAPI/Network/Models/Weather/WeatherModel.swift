//
//  WeatherModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

public struct WeatherModel: Codable {
    public var cod: String?
    public var message: Int?
    public var cnt: Int?
    var list: [List?]
    let city: City?
}

public struct List: Codable {
    let dt: Int?
    let main: Main?
    var weather: [Weather?]
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let sys: Sys?
    let dt_txt: String?
}

public struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Cord?
    let country: String?
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}

public struct Cord: Codable {
    let lat: Double?
    let lon: Double?
}

public struct Main: Codable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let sea_level: Int?
    let grnd_level: Int?
    let humidity: Int?
    let temp_kf: Double?
}

public struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    var icon: String?
}

public struct Clouds: Codable {
    let all: Int?
}

public struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

public struct Sys: Codable {
    let pod: String?
}
