//
//  GradientStylesModel.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import Foundation
import UIKit.UIColor

enum GradientStylesModel {
    case clearSkyDay
    case clearSkyNight
    case thunderstorm
    case fewCloudsDay
    case fewCloudsNight
    case scatteredClouds
    case snow
    case mist
    case brokenClouds
    case showerRain
    case rain
    
    var colors: [CGColor] {
        switch self {
        case .clearSkyDay:
            return [.theme(.colorGradient55BAF3), .theme(.colorGradient2A67EA)]
        case .clearSkyNight:
            return [.theme(.colorGradient052659),.theme(.colorGradient000000.withAlphaComponent(0.0))]
        case .thunderstorm:
            return [.theme(.colorGradient2A67EA), .theme(.colorGradient052659)]
        case .fewCloudsDay:
            return [.theme(.colorGradient0E4FB3), .theme(.colorGradient309DDA)]
        case .fewCloudsNight:
            return [.theme(.colorGradient052659), .theme(.colorGradient2A67EA)]
        case .scatteredClouds:
            return [.theme(.colorGradient5483B3), .theme(.colorGradient2A67EA)]
        case .snow:
            return [.theme(.colorGradientC1E8FF), .theme(.colorGradient2A67EA)]
        case .mist:
            return [.theme(.colorGradient287098), .theme(.colorGradientC1C9DA)]
        case .brokenClouds:
            return [.theme(.colorGradient287098), .theme(.colorGradientC1C9DA)]
        case .showerRain:
            return [.theme(.colorGradient55BAF3), .theme(.colorGradient153756)]
        case .rain:
            return [.theme(.colorGradient3F799A), .theme(.colorGradient112854)]
        }
    }
    
    var locations: [NSNumber] {
        return [0, 1]
    }
    
    var cornerRadius: CGFloat {
        return 50.sizeH
    }
    
    var maskedCorners: CACornerMask {
        return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
