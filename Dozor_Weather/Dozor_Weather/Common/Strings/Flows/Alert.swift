//
//  Alert.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import Foundation

extension String {
    struct Alert {
        private init() {}
        static let noConnection         = "alert_no_connection".localized()
        static let checkConnection      = "alert_check_connection".localized()
        static let tryAgain             = "alert_try_again".localized()
        static let closeAPP             = "alert_close_app".localized()
    }
}

