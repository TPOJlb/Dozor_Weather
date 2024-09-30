//
//  WeatherDBModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import Foundation
import UIKit.UIImage
import RealmSwift

enum IconsDBModel: String, PersistableEnum {
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

class WeatherDBModel: Object {
    @Persisted var cod: String?
    @Persisted var message: Int?
    @Persisted var cnt: Int?
    @Persisted var list: RealmSwift.List<ListDB>
    @Persisted var city: CityDB?
    
    override init() {
        super.init()
    }
}

class ListDB: Object {
    @Persisted var dt: Int?
    @Persisted var main: MainDB?
    @Persisted var weather: RealmSwift.List<WeatherDB>
    @Persisted var clouds: CloudsDB?
    @Persisted var wind: WindDB?
    @Persisted var visibility: Int?
    @Persisted var pop: Double?
    @Persisted var sys: SysDB?
    @Persisted var dt_txt: String?

    override init() {
        super.init()
    }
}

class MainDB: Object {
    @Persisted var temp: Double?
    @Persisted var feels_like: Double?
    @Persisted var temp_min: Double?
    @Persisted var temp_max: Double?
    @Persisted var pressure: Int?
    @Persisted var sea_level: Int?
    @Persisted var grnd_level: Int?
    @Persisted var humidity: Int?
    @Persisted var temp_kf: Double?
    
    override init() {
        super.init()
    }
}

class CityDB: Object {
    @Persisted var id: Int?
    @Persisted var name: String?
    @Persisted var coord: CordDB?
    @Persisted var country: String?
    @Persisted var population: Int?
    @Persisted var timezone: Int?
    @Persisted var sunrise: Int?
    @Persisted var sunset: Int?
    
    override init() {
        super.init()
    }
}

class WeatherDB: Object {
    @Persisted var id: Int?
    @Persisted var main: String?
    @Persisted var descriptions: String?
    @Persisted var icon: IconsDBModel?
    
    override init() {
        super.init()
    }
}

class CloudsDB: Object {
    @Persisted var all: Int?
    
    override init() {
        super.init()
    }
}

class WindDB: Object {
    @Persisted var speed: Double?
    @Persisted var deg: Int?
    @Persisted var gust: Double?
    
    override init() {
        super.init()
    }
}

class CordDB: Object {
    @Persisted var lat: Double?
    @Persisted var lon: Double?
    
    override init() {
        super.init()
    }
}

class SysDB: Object {
    @Persisted var pod: String?
    
    override init() {
        super.init()
    }
}
