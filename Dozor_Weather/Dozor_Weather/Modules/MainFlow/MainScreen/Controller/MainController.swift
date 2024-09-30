//
//  MainController.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import UIKit

class MainController: UIViewController {
    var mainView = MainView()
    
    var weather: WeatherModel? {
        didSet {
            updateLocation()
            sortArray()
        }
    }
    
    var cities: CountryModel?
    
    var sortedList: [[List]] = [] {
        didSet {
            setScrollViewHeight()
            mainView.contentView.tableView.reloadData()
            mainView.contentView.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            listForDayWeather = sortedList.first
        }
    }
    
    var listForDayWeather: [List]? = [] {
        didSet {
            updateWeatherNow(list: listForDayWeather?.first)
            mainView.contentView.collectionView.reloadData()
            mainView.contentView.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        initViewController()
    }

    private func initViewController() {
        DispatchQueue.global(qos: .utility).async {
            self.loadCities()
        }
        getLocation()
        addTargets()
        registerCollectionView()
        registerTableView()
    }
}

//MARK: - Helpers
extension MainController {
    private func addTargets() {
        self.mainView.contentView.cityButton.addTarget(self, action: #selector(changeCity), for: .touchUpInside)
    }
    
    private func registerCollectionView() {
        mainView.contentView.collectionView.delegate = self
        mainView.contentView.collectionView.dataSource = self
        mainView.contentView.collectionView.registerReusableCell(MainCollectionCell.self)
    }
    
    private func registerTableView() {
        mainView.contentView.tableView.delegate = self
        mainView.contentView.tableView.dataSource = self
        mainView.contentView.tableView.registerReusableCell(MainTableCell.self)
    }
    
    private func sortArray() {
        guard let weather else {
            showAlertWithoutConnections()
            return
        }
        guard let model = weather.list else { return }
        var newArray: [[List]] = []
        var helperArray: [List] = []
        for (index, item) in model.enumerated() {
            guard let item else { break }
            if model.indices.contains(index + 1), let nextItem = model[index + 1] {
                if item.dt_txt?.utcToLocal() == nextItem.dt_txt?.utcToLocal() {
                    helperArray.append(item)
                } else {
                    helperArray.append(item)
                    newArray.append(helperArray)
                    helperArray.removeAll()
                }
            } else {
                helperArray.append(item)
                newArray.append(helperArray)
                helperArray.removeAll()
            }
        }
        
        sortedList = newArray
    }
    
    private func saveToDataBase(model: WeatherModel?) {
        guard let model else { return }
        WeatherDBManager.shared.removeAll()
        WeatherDBManager.shared.addWeather(model)
    }
    
    private func showAlertWithoutConnections() {
        let alert = UIAlertController(title: .Alert.noConnection, message: .Alert.checkConnection, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: .Alert.tryAgain, style: UIAlertAction.Style.default, handler: { _ in
            self.getLocation()
        }))
        self.present(alert, animated: true)
    }
    
    private func retryLoadDataFromAPI() {
        getLocation()
    }
}

//MARK: - UpdateUI
extension MainController {
    private func setScrollViewHeight() {
        mainView.contentView.tableViewNumberItems = CGFloat(sortedList.count)
        mainView.scrollView.contentSize.height = mainView.contentView.frame.height
        mainView.scrollView.layoutSubviews()
    }
    
    private func updateLocation() {
        mainView.contentView.city = weather?.city?.name
    }
    
    private func updateWeatherNow(list: List?) {
        mainView.contentView.weatherModel = list
    }
    
    private func updateUIWithInternetConnectionState(connection: Bool) {
        mainView.contentView.cityButton.isEnabled = connection
    }
}

//MARK: - Targets
extension MainController {
    @objc private func changeCity() {
        openChooseCityScreen()
    }
}

//MARK: - Navigation
extension MainController {
    private func openChooseCityScreen() {
        let vc = ChooseCityController()
        vc.cites = cities
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ChooseCityP
extension MainController: ChooseCityP {
    func selectCity(city: CityModel?) {
        guard let latitude = (city?.lat as? NSString)?.doubleValue,
              let longtitude = (city?.lng as? NSString)?.doubleValue else { ProgressHelper.hide()
            return
        }
        loadWeather(latitude: latitude, longitude: longtitude)
    }
}

//MARK: - Network
extension MainController {
    private func getLocation() {
        ProgressHelper.show()
        DozorAPI.locationManager.getLocation { res in
            let location = res.loc?.components(separatedBy: ",")
            guard let latitude = (location?.first as? NSString)?.doubleValue,
                  let longtitude = (location?.last as? NSString)?.doubleValue else {
                ProgressHelper.hide()
                return
            }
            self.updateUIWithInternetConnectionState(connection: true)
            self.loadWeather(latitude: latitude, longitude: longtitude)
        } failure: { _ in
            self.weather = WeatherDBManager.shared.getFirst()
            self.updateUIWithInternetConnectionState(connection: false)
            ProgressHelper.hide()
        }
    }
    
    private func loadWeather(latitude: Double, longitude: Double) {
        DozorAPI.weatherManager.getWeatherFiveDays(latitude: latitude, longitude: longitude) { res in
            self.weather = res
            self.saveToDataBase(model: res)
            ProgressHelper.hide()
        } failure: { error in
            print(error)
        }
    }
    
    private func loadCities() {
        DozorAPI.citiesManager.getCities { res in
            self.cities = res
        } failure: { error in
            print(error)
        }
    }
}

//MARK: - CollectionView delegate/dataSource
extension MainController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listForDayWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56.sizeH, height: 84.sizeH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40.sizeW, bottom: 0, right: 40.sizeH)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let model = listForDayWeather?[row]
        let cell: MainCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let model = listForDayWeather?[row]
        updateWeatherNow(list: model)
    }
}

//MARK: - TableView delegate/dataSource
extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model = sortedList[row]
        let cell: MainTableCell = tableView.dequeueReusableCell(for: indexPath)
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let model = sortedList[row]
        listForDayWeather = model
    }
}
