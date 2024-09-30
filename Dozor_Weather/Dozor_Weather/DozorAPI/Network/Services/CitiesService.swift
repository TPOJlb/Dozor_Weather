//
//  CitiesService.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import Foundation


import Foundation
import UIKit

internal class CitiesService {
    
    private let api = NetworkHelper()
    
    func getCities(success: @escaping (CountryModel) -> Void,
                     failure: @escaping (Error) -> Void) {
        guard let url = Bundle.main.url(forResource: "Cities", withExtension: "json") else {
            return
        }
        api.get(apiRoute: url, success: { (model: CountryModel) in
            success(model)
        }, failure: { error in
            failure(error)
        })
    }
}
