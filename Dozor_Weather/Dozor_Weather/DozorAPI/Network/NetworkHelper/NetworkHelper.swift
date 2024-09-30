//
//  NetworkHelper.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation
import Alamofire

internal class NetworkHelper: NSObject {
    // MARK: Public Methods
    func get<T: Decodable>(apiRoute: APIConstants.APIRoutes, params: [String: Any]? = nil, headers: [String: String] = [:], success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        let httpHeaders = HTTPHeaders(headers)
        
        APIManager.manager.request(apiRoute.domain + apiRoute.urlString, method: .get, parameters: params, headers: httpHeaders).validate().responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let model):
                success(model)
            case .failure(let error):
                let finalError = self.handleAFError(error: error)
                failure(finalError)
            }
        }
    }
    
    func get<T: Decodable>(apiRoute: URL, params: [String: Any]? = nil, headers: [String: String] = [:], success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        let httpHeaders = HTTPHeaders(headers)
        
        APIManager.manager.request(apiRoute, method: .get, parameters: params, headers: httpHeaders).validate().responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let model):
                success(model)
            case .failure(let error):
                let finalError = self.handleAFError(error: error)
                failure(finalError)
            }
        }
    }
    
    func post<T: Decodable>(apiRoute: APIConstants.APIRoutes, params: [String: Any]? = nil, headers: [String: String] = [:], success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        let httpHeaders = HTTPHeaders(headers)
        
        APIManager.manager.request(apiRoute.domain + apiRoute.urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: httpHeaders).validate().responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let model):
                success(model)
            case .failure(let error):
                let finalError = self.handleAFError(error: error)
                failure(finalError)
            }
        }
    }
}

// MARK: helpers and handlers
extension NetworkHelper {
    private func handleAFError(error: AFError) -> Error {
        if let apiRetryError = error.underlyingError,
           let originalError = apiRetryError.asAFError?.underlyingError {
            // in case if have request interceptor with request retry
            return originalError
        } else {
            // in case if we don't have request interceptor
            return error
        }
    }
}
