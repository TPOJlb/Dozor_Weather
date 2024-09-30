//
//  Double + TemperatureString.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 29.09.2024.
//

import Foundation

extension Double {
    func toTemperatureString() -> String {
        let roundedInt = Int(self.rounded())
        return String(format: "%d°", roundedInt)
    }
    
    func toWindString() -> String {
        let roundedInt = Int(self.rounded())
        return String(format: "%d m/s", roundedInt)
    }
    
    func tochanceOfRainString() -> String? {
        let roundedInt = Int(self.rounded())
        return String(format: "%d %", roundedInt)
    }
}
