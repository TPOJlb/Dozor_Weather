//
//  IconsModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation
import UIKit

enum IconsModel: String, Codable {
    case clearSkyDay            = "01d"
    case clearSkyNight          = "01n"
    case fewCloudsDay           = "02d"
    case fewCloudsNight         = "02n"
    case scatteredCloudsDay     = "03d"
    case scatteredCloudsNight   = "03n"
    case brokenCloudsDay        = "04d"
    case brokenCloudsNight      = "04n"
    case showerRainDay          = "09d"
    case showerRainNight        = "09n"
    case rainDay                = "10d"
    case rainNight              = "10n"
    case thunderstormDay        = "11d"
    case thunderstormNight      = "11n"
    case snowDay                = "13d"
    case snowNight              = "13n"
    case mistDay                = "50d"
    case mistNight              = "50n"
    
    var image: UIImage? {
        switch self {
        case .clearSkyDay:
            return .clearSkyDay
        case .clearSkyNight:
            return .clearSkyNight
        case .fewCloudsDay:
            return .fewCloudsDay
        case .fewCloudsNight:
            return .fewCloudsNight
        case .scatteredCloudsDay:
            return .scatteredCloudsDay
        case .scatteredCloudsNight:
            return .scatteredCloudsNight
        case .brokenCloudsDay:
            return .brokenCloudsDay
        case .brokenCloudsNight:
            return .brokenCloudsNight
        case .showerRainDay:
            return .showerRainDay
        case .showerRainNight:
            return .showerRainNight
        case .rainDay:
            return .rainDay
        case .rainNight:
            return .rainNight
        case .thunderstormDay:
            return .thunderstormDay
        case .thunderstormNight:
            return .thunderstormNight
        case .snowDay:
            return .snowDay
        case .snowNight:
            return .snowNight
        case .mistDay:
            return .mistDay
        case .mistNight:
            return .mistNight
        }
    }
}
