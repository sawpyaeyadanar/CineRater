//
//  APIEndPoint.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 28/8/23.
//

import Foundation
enum APIEndPoint {
    // MARK: - Cases
    case trending
    case credits( id: Int)
    case search
    case person(id: Int)


    
    // MARK: - Properties
    var urlComponent: URLComponents {
        URLComponents(url: URLManager.apiBaseURL, resolvingAgainstBaseURL: false)!
        
    }
/*
    var request: URLRequest {
        var request = URLRequest(url: urlComponent.url!)
        request.addHeaders(headers)
        request.httpMethod = httpMethod.rawValue
        request.url?.append(queryItems: [URLQueryItem(name: "api_key", value: URLManager.apiKey)])
        return request
    }
    
    // MARK: -
    
    private var url: URL {
        URLManager.apiBaseURL.appendingPathComponent("trending/all/day")
    }
*/
     var path: String {
        switch self {
        case .trending:
            return "trending/all/day"
        case let .credits( movieID):
             return "movie/\(movieID)/credits"
        case .search:
            return "search/movie"
        case let .person(id):
            return "person/\(id)"
        }
    }
    
    var headers: Headers {
        [
            "Content-Type" : "application/json"
        ]
    }
    
     var httpMethod: HttpMethod {
        switch self {
        case .trending:
            return .get
        case .credits(_):
            return .get
        case .search:
            return  .get
        case .person(_):
            return .get
        }
    }
    
}
 extension URLRequest {
    mutating func addHeaders(_ headers: Headers) {
        headers.forEach { header, value in
            addValue(value, forHTTPHeaderField: header)
        }
    }
}
