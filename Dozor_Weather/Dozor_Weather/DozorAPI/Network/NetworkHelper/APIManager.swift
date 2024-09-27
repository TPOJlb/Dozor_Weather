//
//  APIManager.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation
import Alamofire

class APIManager {
    static let manager: Alamofire.Session = {
        
        let config = URLSessionConfiguration.af.ephemeral
        config.requestCachePolicy = .reloadIgnoringCacheData
        config.urlCache = nil

        let session = Session(configuration: config)
        return session
    }()
}
