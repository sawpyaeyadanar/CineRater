//
//  APIError.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 25/8/23.
//

import Foundation
enum APIError: Error {
    case failedRequest
    case notConnectedToInternet
    case dataCorrupted(DecodingError.Context)
    case decodingKeyNotFoundError(key: CodingKey, context: String)
    case decodingValueNotFoundError(key: Any.Type, context: String)
    case decodingTypeMismatchError(key: Any.Type, context: String)
    
    var message: String {
        switch self {
        case .failedRequest:
            return "Failed to fetch data"
        case .notConnectedToInternet:
            return "Check the internet connection"
        case let .dataCorrupted(context):
            return "\(context.debugDescription)"
        case .decodingKeyNotFoundError(key: let key, context: let context):
            return "Key \(key) not found:, \(context.debugDescription)"
        case .decodingValueNotFoundError(key: let key, context: let context):
            return "Key \(key) not found:, \(context.debugDescription)"
        case .decodingTypeMismatchError(key: let key, context: let context):
            return "Key \(key) not found:, \(context.debugDescription)"
        }
    }
}
