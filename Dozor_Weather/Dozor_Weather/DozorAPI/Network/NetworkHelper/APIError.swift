//
//  APIError.swift
//  Dozor_Weather
//
//  Created by Muraviov Kyrylo on 27.09.2024.
//

import Foundation

enum APIError: Error {
    case failedWithNoError
    case failWithNoResponse
    case serverError(errorString: String)
}
