//
//  CitiesModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import Foundation

public struct CountryModel: Codable {
    var name: String
    var regions: [RegionModel]
}

public struct RegionModel: Codable {
    var name: String
    var cities: [CityModel]
}

public struct CityModel: Codable {
    var name: String
    var lat: String
    var lng: String
}
