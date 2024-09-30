//
//  MainContentView.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import UIKit

class MainContentView: UIView {
    
    var city: String?
    
    var weatherModel: List? {
        didSet {
            handleUI()
        }
    }
    
    var tableViewNumberItems: CGFloat = 0 {
        didSet {
            tableView.snp.updateConstraints { make in
                make.height.equalTo(87.sizeH * tableViewNumberItems)
            }
            self.layoutIfNeeded()
        }
    }
    
    let cityButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.image = .mainLocation.withRenderingMode(.alwaysTemplate)
        configuration.imagePlacement = .leading
        configuration.baseBackgroundColor = .clear
        configuration.imagePadding = 0
        configuration.baseForegroundColor = .colorText
        let obj = UIButton(configuration: configuration)
        obj.isHidden = true
        return obj
    }()
    
    let gradientView: GradientView = {
        let obj = GradientView()
        return obj
    }()
    
    let weatherImageView: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    let dayLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.semibold, 24)
        obj.textAlignment = .left
        obj.textColor = .colorText
        return obj
    }()
    
    let temperatureLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.bold, 64)
        obj.textAlignment = .left
        obj.textColor = .colorText
        return obj
    }()
    
    let weatherDetailsLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.regular, 16)
        obj.textAlignment = .left
        obj.textColor = .colorC1E8FF
        return obj
    }()
    
    let gradientSeparateLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .color7DA0CA
        obj.isHidden = true
        return obj
    }()
    
    let windDetailsView: WeatherDetailsView = {
        let obj = WeatherDetailsView()
        return obj
    }()
    
    let humidityDetailsView: WeatherDetailsView = {
        let obj = WeatherDetailsView()
        return obj
    }()
    
    let chanceOfRainDetailsView: WeatherDetailsView = {
        let obj = WeatherDetailsView()
        return obj
    }()
    
    let maxDetailsView: WeatherDetailsView = {
        let obj = WeatherDetailsView()
        return obj
    }()
    
    let minDetailsView: WeatherDetailsView = {
        let obj = WeatherDetailsView()
        return obj
    }()
    
    let pressureDetailsView: WeatherDetailsView = {
        let obj = WeatherDetailsView()
        return obj
    }()
    
    let weatherDetailsStackView: UIStackView = {
        let obj = UIStackView()
        obj.axis = .horizontal
        obj.alignment = .center
        obj.distribution = .equalSpacing
        return obj
    }()
    
    let todayTitleLabel: UILabel = {
        let obj = UILabel()
        obj.textAlignment = .left
        obj.textColor = .colorText
        obj.font = .theme(.semibold, 24)
        obj.isHidden = true
        obj.text = "Today"
        return obj
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10.sizeW
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.backgroundColor = .clear
        return obj
    }()
    
    let collectionViewSeparateLineView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .color7DA0CA
        obj.isHidden = true
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
        obj.separatorStyle = .none
        obj.backgroundColor = .clear
        obj.showsVerticalScrollIndicator = false
        obj.allowsMultipleSelection = false
        obj.isScrollEnabled = false
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(gradientView)
        gradientView.addSubview(cityButton)
        gradientView.addSubview(weatherImageView)
        gradientView.addSubview(dayLabel)
        gradientView.addSubview(temperatureLabel)
        gradientView.addSubview(weatherDetailsLabel)
        gradientView.addSubview(gradientSeparateLineView)
        gradientView.addSubview(weatherDetailsStackView)
        weatherDetailsStackView.addArrangedSubview(windDetailsView)
        weatherDetailsStackView.addArrangedSubview(humidityDetailsView)
        weatherDetailsStackView.addArrangedSubview(chanceOfRainDetailsView)
        weatherDetailsStackView.addArrangedSubview(maxDetailsView)
        weatherDetailsStackView.addArrangedSubview(minDetailsView)
        weatherDetailsStackView.addArrangedSubview(pressureDetailsView)
        addSubview(todayTitleLabel)
        addSubview(collectionView)
        addSubview(collectionViewSeparateLineView)
        addSubview(tableView)
        
        gradientView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        cityButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10.sizeH)
            make.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(cityButton.snp.bottom).offset(10.sizeH)
            make.leading.equalToSuperview()
            make.size.equalTo(192.sizeH)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(cityButton.snp.bottom).offset(47.sizeH)
            make.leading.equalTo(weatherImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(24.sizeW)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom)
            make.leading.equalTo(weatherImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(24.sizeW)
        }
        
        weatherDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.leading.equalTo(weatherImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(24.sizeW)
        }
        
        gradientSeparateLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24.sizeW)
            make.top.equalTo(weatherImageView.snp.bottom)
            make.height.equalTo(1)
        }
        
        weatherDetailsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(33.sizeW)
            make.top.equalTo(gradientSeparateLineView.snp.bottom).offset(29.sizeH)
            make.bottom.equalToSuperview().offset(-29.sizeH)
        }
        
        todayTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(gradientView.snp.bottom).offset(16.sizeH)
            make.leading.trailing.equalToSuperview().inset(40.sizeW)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(todayTitleLabel.snp.bottom).offset(14.sizeH)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(84.sizeH)
        }
        
        collectionViewSeparateLineView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16.sizeH)
            make.leading.trailing.equalToSuperview().inset(24.sizeW)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionViewSeparateLineView.snp.bottom).offset(8.sizeH)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
}

//MARK: HandleUI
extension MainContentView {
    private func handleUI() {
        guard let weatherModel,
              let main = weatherModel.main,
              let weatherFirst = weatherModel.weather?.first,
              let city = city,
              let dateString = weatherModel.dt_txt,
              let temperature = main.temp?.toTemperatureString(),
              let pop = weatherModel.pop,
              let wind = weatherModel.wind?.speed?.toWindString(),
              let humidity = main.humidity?.description,
              let chanceOfRain = (pop * 100).tochanceOfRainString(),
              let tempMax = main.temp_max?.toTemperatureString(),
              let tempMin = main.temp_min?.toTemperatureString(),
              let pressure = main.pressure?.description
        else { return }
        
        let iconType = weatherFirst?.icon
        weatherImageView.image = iconType?.image
        gradientView.gradient = .gradientLayer(for: getStyleGradient(iconType: iconType))
        cityButton.configuration?.attributedTitle = getAttributedStringForButton()
        dayLabel.text = dateString.utcToLocal()
        todayTitleLabel.text = dateString.relativeDateFormatter()
        temperatureLabel.text = temperature
        weatherDetailsLabel.text = weatherFirst?.description?.capitalized
        windDetailsView.model = WeatherDetailsModel(type: .wind, title: wind)
        humidityDetailsView.model = WeatherDetailsModel(type: .humidity, title: humidity)
        chanceOfRainDetailsView.model = WeatherDetailsModel(type: .chanceOfRain, title: chanceOfRain)
        maxDetailsView.model = WeatherDetailsModel(type: .tempMax, title: tempMax)
        minDetailsView.model = WeatherDetailsModel(type: .tempMin, title: tempMin)
        pressureDetailsView.model = WeatherDetailsModel(type: .pressure, title: pressure)
        cityButton.isHidden = false
        gradientSeparateLineView.isHidden = false
        todayTitleLabel.isHidden = false
        collectionViewSeparateLineView.isHidden = false
    }
}

//MARK: Helpers
extension MainContentView {
    private func getStyleGradient(iconType: IconsModel?) -> GradientStylesModel? {
        guard let iconType else { return nil }
        
        switch iconType {
        case .clearSkyDay:
            return .clearSkyDay
        case .clearSkyNight:
            return .clearSkyNight
        case .fewCloudsDay:
            return .fewCloudsDay
        case .fewCloudsNight:
            return .fewCloudsNight
        case .scatteredCloudsDay, .scatteredCloudsNight:
            return .scatteredClouds
        case .brokenCloudsDay, .brokenCloudsNight:
            return .brokenClouds
        case .mistDay, .mistNight:
            return .mist
        case .showerRainDay, .showerRainNight:
            return .showerRain
        case .rainDay, .rainNight:
            return .rain
        case .thunderstormDay, .thunderstormNight:
            return .thunderstorm
        case .snowDay, .snowNight:
            return .snow
        }
    }
    
    private func getAttributedStringForButton() -> AttributedString? {
        guard let city else { return nil }
        var container = AttributeContainer()
        container.font = .theme(.medium, 24)
        container.foregroundColor = .colorText
        return AttributedString(city, attributes: container)
    }
}
