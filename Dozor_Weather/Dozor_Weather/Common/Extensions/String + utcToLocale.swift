//
//  String + utcToLocale.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 28.09.2024.
//

import Foundation

extension String {
    func utcToLocal(dateFormat: String = "EEEE, MMM d") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = dateFormat
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func relativeDateFormatter(dateFormat: String = "yyyy-MM-dd") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = dateFormat
        
            let formatedString = dateFormatter.string(from: date)
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = dateFormat
            guard let date = inputFormatter.date(from: formatedString) else { return nil }
            let relativeDateFormatter = DateFormatter()
            relativeDateFormatter.timeStyle = .none
            relativeDateFormatter.dateStyle = .long
            relativeDateFormatter.locale = Locale(identifier: "en_GB")
            relativeDateFormatter.doesRelativeDateFormatting = true
            return relativeDateFormatter.string(from: date)
        }
        return nil
    }
}
