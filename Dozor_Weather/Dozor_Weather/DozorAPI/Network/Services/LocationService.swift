//
//  LocationService.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation
import UIKit

internal class LocationService {
    
    private let api = NetworkHelper()
    
    func getLocation(success: @escaping (LocationModel) -> Void,
                     failure: @escaping (Error) -> Void) {
        api.get(apiRoute: .location, success: { (model: LocationModel) in
            success(model)
        }, failure: { error in
            failure(error)
        })
    }
}

