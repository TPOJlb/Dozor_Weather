//
//  MainTableCell.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 29.09.2024.
//

import Foundation
import UIKit

class MainTableCell: UITableViewCell,Reusable {
    
    var model: [List?] = [] {
        didSet {
            handleUI()
        }
    }
    
    let dayLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.medium, 24)
        obj.textColor = .color7DA0CA
        obj.textAlignment = .left
        return obj
    }()
    
    let weatherImageView: UIImageView = {
        let obj = UIImageView()
        obj.image = IconsModel.thunderstormDay.image
        return obj
    }()
    
    let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.regular, 12)
        obj.textColor = .colorC1E8FF
        obj.textAlignment = .left
        return obj
    }()
    
    let temperatureDayLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.bold, 32)
        obj.textColor = .colorC1E8FF
        obj.textAlignment = .left
        return obj
    }()
    let temperatureNightLabel: UILabel = {
        let obj = UILabel()
        obj.font = .theme(.medium, 24)
        obj.textColor = .color7DA0CA
        obj.textAlignment = .left
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .gray
        backgroundColor = .clear
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(temperatureDayLabel)
        contentView.addSubview(temperatureNightLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(38.sizeW)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(48.sizeH)
            make.top.bottom.equalToSuperview().inset(14.sizeH)
            make.leading.equalToSuperview().offset(114.sizeW)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView.snp.trailing)
            make.centerY.equalToSuperview()
        }
        
        temperatureDayLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-99.sizeW)
            make.centerY.equalToSuperview()
        }
        
        temperatureNightLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-38.sizeW)
            make.centerY.equalToSuperview()
        }
    }
}

//MARK: - HandleUI
extension MainTableCell {
    private func handleUI() {
        let day = findDayOfWeek()
        let temperature = findMaxMinTemperature()
        let icon = findMostFrequentIcon()
        let description = findMostFrequentDescription()
        dayLabel.text = day
        weatherImageView.image = icon
        descriptionLabel.text = description?.capitalized
        temperatureDayLabel.text = temperature.max?.toTemperatureString()
        temperatureNightLabel.text = temperature.min?.toTemperatureString()
    }
}

//MARK: - Helpers
extension MainTableCell {
    private func findMaxMinTemperature() -> (min: Double?, max: Double?) {
        var maxTemperatureArray: [Double] = []
        var minTemperatureArray: [Double] = []
        for listItem in model {
            guard let listItem,
                  let main = listItem.main,
                  let maxTemperature = main.temp_max,
                  let minTemperature = main.temp_min else { break }
            maxTemperatureArray.append(maxTemperature)
            minTemperatureArray.append(minTemperature)
        }
        
        let maxTemperature = maxTemperatureArray.max()
        let minTemperature = minTemperatureArray.min()
        return (minTemperature, maxTemperature)
    }
    
    private func findMostFrequentIcon() -> UIImage? {
        var imageTypes = [IconsModel]()
        for listItem in model {
            guard let listItem, let weatherArray = listItem.weather else { break }
            for weatherItem in weatherArray {
                guard let weatherItem, let icon = weatherItem.icon else { break }
                imageTypes.append(icon)
            }
        }
        
        var typeCounts = [IconsModel: Int]()
        imageTypes.forEach { typeCounts[$0] = (typeCounts[$0] ?? 0) + 1 }
        if let (type, _) = typeCounts.max(by: {$0.1 < $1.1}) {
            return type.image
        }
        return nil
    }
    
    private func findMostFrequentDescription() -> String? {
        var imageTypes = [String]()
        for listItem in model {
            guard let listItem, let weatherArray = listItem.weather else { break }
            for weatherItem in weatherArray {
                guard let weatherItem, let description = weatherItem.description else { break }
                imageTypes.append(description)
            }
        }
        
        var typeCounts = [String: Int]()
        imageTypes.forEach { typeCounts[$0] = (typeCounts[$0] ?? 0) + 1 }
        if let (desctiprion, _) = typeCounts.max(by: {$0.1 < $1.1}) {
            return desctiprion
        }
        return nil
    }
    
    private func findDayOfWeek() -> String? {
        guard let firstItem = model.first, let date = firstItem?.dt_txt else { return nil }
        let dayOfWeek = date.utcToLocal(dateFormat: "EEE")
        return dayOfWeek
    }
}
