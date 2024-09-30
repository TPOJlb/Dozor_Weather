//
//  CitiesManager.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 30.09.2024.
//

import Foundation

public class CitiesManager {
    
    private let citiesService = CitiesService()
    
    public func getCities(success: @escaping (CountryModel) -> Void,
                                   failure: @escaping (Error) -> Void) {
        citiesService.getCities { res in
            success(res)
        } failure: { error in
            failure(error)
        }

    }
}
