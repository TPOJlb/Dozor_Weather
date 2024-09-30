//
//  WeatherManager.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 29.09.2024.
//

import Foundation
import RealmSwift
class WeatherDBManager {
    static let shared = WeatherDBManager()
    private let database = DatabaseManager.shared
    
    init() {
    }
    
    func addWeather(_ model: WeatherModel) {
        guard let modelDB = weatherModelToWeatherDB(model: model) else { return }
        database.add(model: modelDB)
    }
    
    func getAll() -> [WeatherDBModel] {
        return database.getAll()
    }
    
    func getFirst() -> WeatherModel? {
        let allDB = getAll()
        guard let firstDB = allDB.first else { return nil }
        let model = weatherDBToWeatherModel(model: firstDB)
        return model
    }
    
    func remove(_ model: WeatherDBModel) {
        database.remove(model: model)
    }
    
    func remove(_ models: [WeatherDBModel]) {
        try? database.realm.write({
            database.realm.delete(models)
        })
    }
    
    func removeAll() {
        database.removeAll()
    }
    
    private func weatherModelToWeatherDB(model: WeatherModel) -> WeatherDBModel? {
        let weatherDBModel = WeatherDBModel()

        let cityDB = CityDB()
        let city = model.city
        
        let cordDB = CordDB()
        let cord = model.city?.coord
        
        cordDB.lat = cord?.lat
        cordDB.lon = cord?.lon
        
        cityDB.id = city?.id
        cityDB.name = city?.name
        cityDB.coord = cordDB
        cityDB.country = city?.country
        cityDB.population = city?.population
        cityDB.timezone = city?.timezone
        cityDB.sunrise = city?.sunrise
        cityDB.sunset = city?.sunset
        
        let listsDBArray = weatherDBModel.list
        let lists = model.list
        
        guard let lists else { return nil }
        
        for list in lists {
            let listDB = ListDB()
            
            let mainDB = MainDB()
            let main = list?.main
            
            mainDB.temp = main?.temp
            mainDB.feels_like = main?.feels_like
            mainDB.temp_min = main?.temp_min
            mainDB.temp_max = main?.temp_max
            mainDB.pressure = main?.pressure
            mainDB.sea_level = main?.sea_level
            mainDB.grnd_level = main?.grnd_level
            mainDB.humidity = main?.humidity
            mainDB.temp_kf = main?.temp_kf
            
            let cloudsDB = CloudsDB()
            let clouds = list?.clouds
            
            cloudsDB.all = clouds?.all
            
            let windDB = WindDB()
            let wind = list?.wind
            
            windDB.speed = wind?.speed
            windDB.deg = wind?.deg
            windDB.gust = wind?.gust
            
            let sysDB = SysDB()
            let sys = list?.sys
            
            sysDB.pod = sys?.pod
            
            let weatherDB = listDB.weather
            let weather = list?.weather
            
            guard let weather else { break }
                for item in weather {
                    let itemDB = WeatherDB()
                    itemDB.id = item?.id
                    itemDB.main = item?.main
                    itemDB.descriptions = item?.description
                    
                    var iconDB = IconsDBModel()
                    guard let icon = item?.icon else { break }
                    switch icon {
                    case .clearSkyDay:
                        iconDB = .clearSkyDay
                    case .clearSkyNight:
                        iconDB = .clearSkyNight
                    case .fewCloudsDay:
                        iconDB = .fewCloudsDay
                    case .fewCloudsNight:
                        iconDB = .fewCloudsNight
                    case .scatteredCloudsDay:
                        iconDB = .scatteredCloudsDay
                    case .scatteredCloudsNight:
                        iconDB = .scatteredCloudsNight
                    case .brokenCloudsDay:
                        iconDB = .brokenCloudsDay
                    case .brokenCloudsNight:
                        iconDB = .brokenCloudsNight
                    case .showerRainDay:
                        iconDB = .showerRainDay
                    case .showerRainNight:
                        iconDB = .showerRainNight
                    case .rainDay:
                        iconDB = .rainDay
                    case .rainNight:
                        iconDB = .rainNight
                    case .thunderstormDay:
                        iconDB = .thunderstormDay
                    case .thunderstormNight:
                        iconDB = .thunderstormNight
                    case .snowDay:
                        iconDB = .snowDay
                    case .snowNight:
                        iconDB = .snowNight
                    case .mistDay:
                        iconDB = .mistDay
                    case .mistNight:
                        iconDB = .mistNight
                    }
                    
                    itemDB.icon = iconDB
                    
                    weatherDB.append(itemDB)
                }
            listDB.dt = list?.dt
            listDB.visibility = list?.visibility
            listDB.pop = list?.pop
            listDB.dt_txt = list?.dt_txt
            listDB.main = mainDB
            listDB.clouds = cloudsDB
            listDB.wind = windDB
            listDB.sys = sysDB
            listDB.weather = weatherDB
            
            listsDBArray.append(listDB)
        }
        
        weatherDBModel.cod = model.cod
        weatherDBModel.message = model.message
        weatherDBModel.cnt = model.cnt
        weatherDBModel.list = listsDBArray
        weatherDBModel.city = cityDB
        
        return weatherDBModel
    }
    
    private func weatherDBToWeatherModel(model: WeatherDBModel) -> WeatherModel? {
        var weatherModel = WeatherModel()

        var city = City()
        let cityDB = model.city
        
        var cord = Cord()
        let cordDB = model.city?.coord
        
        cord.lat = cordDB?.lat
        cord.lon = cordDB?.lon
        
        city.id = cityDB?.id
        city.name = cityDB?.name
        city.coord = cord
        city.country = cityDB?.country
        city.population = cityDB?.population
        city.timezone = cityDB?.timezone
        city.sunrise = cityDB?.sunrise
        city.sunset = cityDB?.sunset
        
        var listsArray: [List?] = []
        let listsDBArray = model.list
        
        for listDB in listsDBArray {
            var list = List()
            
            var main = Main()
            let mainDB = listDB.main
            
            main.temp = mainDB?.temp
            main.feels_like = mainDB?.feels_like
            main.temp_min = mainDB?.temp_min
            main.temp_max = mainDB?.temp_max
            main.pressure = mainDB?.pressure
            main.sea_level = mainDB?.sea_level
            main.grnd_level = mainDB?.grnd_level
            main.humidity = mainDB?.humidity
            main.temp_kf = mainDB?.temp_kf
            
            var clouds = Clouds()
            let cloudsDB = listDB.clouds
            
            clouds.all = cloudsDB?.all
            
            var wind = Wind()
            let windDB = listDB.wind
            
            wind.speed = windDB?.speed
            wind.deg = windDB?.deg
            wind.gust = windDB?.gust
            
            var sys = Sys()
            let sysDB = listDB.sys
            
            sys.pod = sysDB?.pod
            
            var weather = [Weather?]()
            let weatherDB = listDB.weather
            
                for itemDB in weatherDB {
                    var item: Weather? = Weather()
                    item?.id = itemDB.id
                    item?.main = itemDB.main
                    item?.description = itemDB.descriptions
                    
                    var icon: IconsModel?
                    guard let iconDB = itemDB.icon else {
                        break
                    }
                    switch iconDB {
                    case .clearSkyDay:
                        icon = .clearSkyDay
                    case .clearSkyNight:
                        icon = .clearSkyNight
                    case .fewCloudsDay:
                        icon = .fewCloudsDay
                    case .fewCloudsNight:
                        icon = .fewCloudsNight
                    case .scatteredCloudsDay:
                        icon = .scatteredCloudsDay
                    case .scatteredCloudsNight:
                        icon = .scatteredCloudsNight
                    case .brokenCloudsDay:
                        icon = .brokenCloudsDay
                    case .brokenCloudsNight:
                        icon = .brokenCloudsNight
                    case .showerRainDay:
                        icon = .showerRainDay
                    case .showerRainNight:
                        icon = .showerRainNight
                    case .rainDay:
                        icon = .rainDay
                    case .rainNight:
                        icon = .rainNight
                    case .thunderstormDay:
                        icon = .thunderstormDay
                    case .thunderstormNight:
                        icon = .thunderstormNight
                    case .snowDay:
                        icon = .snowDay
                    case .snowNight:
                        icon = .snowNight
                    case .mistDay:
                        icon = .mistDay
                    case .mistNight:
                        icon = .mistNight
                    }
                    
                    item?.icon = icon
                    
                    guard let item else {
                        break
                    }
                    
                    weather.append(item)
                }
            
            list.dt = listDB.dt
            list.visibility = listDB.visibility
            list.pop = listDB.pop
            list.dt_txt = listDB.dt_txt
            list.main = main
            list.clouds = clouds
            list.wind = wind
            list.sys = sys
            list.weather = weather
            
            listsArray.append(list)
        }
        
        weatherModel.cod = model.cod
        weatherModel.message = model.message
        weatherModel.cnt = model.cnt
        weatherModel.list = listsArray
        weatherModel.city = city
        
        return weatherModel
    }
}

