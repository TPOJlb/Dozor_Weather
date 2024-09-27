//
//  LocationManager.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

public class LocationManager {
    
    private let locationService = LocationService()
    
    public func getLocation(success: @escaping (LocationModel) -> Void,
                                   failure: @escaping (Error) -> Void) {
        locationService.getLocation { res in
            success(res)
        } failure: { error in
            failure(error)
        }

    }
}
