//
//  MainController.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit

class MainController: UIViewController {
    var mainView = MainView()
    
    var weather: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        initViewController()
    }
    
    private func initViewController() {
        getLocation()
    }
}

//MARK: UpdateUI
extension MainController {
    private func updateLocation(location: LocationModel) {
        mainView.location = location
    }
}

//MARK: Network
extension MainController {
    private func loadWeather(latitude: Double, longitude: Double) {
        DozorAPI.weatherManager.getWeatherFiveDays(latitude: latitude, longitude: longitude) { res in
            
            self.weather = res
            
            for (index, listItem) in res.list.enumerated() {
                guard let listItem else { return }
                for (subindex, weatherItem) in listItem.weather.enumerated() {
                    guard let weatherItem, let icon = weatherItem.icon else { return }
                    self.weather?.list[index]?.weather[subindex]?.icon = String(format: Constants.imageURL, icon)
                }
            }
            ProgressHelper.hide()
        } failure: { error in
            print(error)
        }

    }
    
    private func getLocation() {
        ProgressHelper.show()
        DozorAPI.locationManager.getLocation { res in
            self.updateLocation(location: res)
            let location = res.loc?.components(separatedBy: ",")
            guard let latitude = (location?.first as? NSString)?.doubleValue,
                  let longtitude = (location?.last as? NSString)?.doubleValue else {
                ProgressHelper.hide()
                return
            }
            
            self.loadWeather(latitude: latitude, longitude: longtitude)
        } failure: { error in
            print(error)
        }
    }
}
