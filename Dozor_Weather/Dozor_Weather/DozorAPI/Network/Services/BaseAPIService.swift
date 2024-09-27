//
//  BaseAPIService.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

internal class BaseAPIService {
    typealias ErrorCallback = (Error) -> Void
    
    internal func handleAPIResponse<T: Codable>(model: BaseAPIResponseModel<T>,
                                                success: @escaping (T) -> Void,
                                                failure: @escaping (Error) -> Void) {
        if model.cod == "200" {
            guard let response = model.data else {
                failure(APIError.failWithNoResponse)
                return
            }
            
            success(response)
        } else {
            if let error = model.cod {
                failure(APIError.serverError(errorString: error))
            } else {
                failure(APIError.failedWithNoError)
            }
        }
    }
    
    internal func handleBaseAPIResponse(model: BaseAPIResponseModel<Bool>,
                                        success: @escaping (Bool) -> Void,
                                        failure: @escaping (Error) -> Void) {
        if model.cod == "200" {
            success(true)
        } else {
            if let error = model.cod {
                failure(APIError.serverError(errorString: error))
            } else {
                failure(APIError.failedWithNoError)
            }
        }
    }
}

