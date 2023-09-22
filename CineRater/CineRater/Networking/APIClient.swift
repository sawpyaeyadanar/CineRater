//
//  APIClient.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 25/8/23.
//

import Foundation
import Combine

class APIClient: APITrendingService {
    func searchTrending(query: String, pageIndex: Int) -> AnyPublisher<TrendingResults, APIError> {
           return APIService.shared.request(.search, parameters:
                                        [
                                            "language": "en-US",
                                            "page": "\(pageIndex)",
                                            "include_adult": "false",
                                            "query": "\(query)"
                                        ])
    }

    func getTrendingList() -> AnyPublisher<TrendingResults, APIError> {
        APIService.shared.request(.trending)
    }
   
}

extension APIClient: APIDetailsService {

    
    func getMovieCredit(for movieID: Int) -> AnyPublisher<MovieCredits, APIError> {
        APIService.shared.request(.credits(id: movieID))
    }
    
    func loadCastProfiles(id: Int) -> AnyPublisher<CastProfile, APIError> {
        APIService.shared.request(.person(id: id))
    }

}


class APIService {
    private init() {}
    static let shared = APIService()
    func request<T: Decodable>(_ endpoint: APIEndPoint, parameters: [String: String] = [:]) -> AnyPublisher<T, APIError> {
       
        var urlComponent = endpoint.urlComponent
        urlComponent.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value)}
        urlComponent.queryItems?.append(URLQueryItem(name: "api_key", value: URLManager.apiKey))
        
        
        var request = URLRequest(url: urlComponent.url!)
        request.url?.appendPathComponent(endpoint.path)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addHeaders(endpoint.headers)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        
       // debugPrint(urlComponent)
       // debugPrint(request)
        
         return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> T in
                guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode)
                else {
                    throw APIError.failedRequest
                }
                return try JSONDecoder().decode(T.self, from: data)
//                do {
//                    return try JSONDecoder().decode(T.self, from: data)
//                }  catch let DecodingError.dataCorrupted(context) {
//                    print(context)
//                    throw APIError.dataCorrupted(context)
//                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                    throw APIError.decodingKeyNotFoundError(key: key, context: context.debugDescription)
//                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                    throw APIError.decodingValueNotFoundError(key: value, context: context.debugDescription)
//                } catch let DecodingError.typeMismatch(type, context)  {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                    throw APIError.decodingTypeMismatchError(key: type, context: context.debugDescription)
//                } catch {
//                    print("error: ", error)
//                    throw APIError.failedRequest
//                }
                
            }
        
            .mapError{ error -> APIError in
               
                print(" there is no error \(error.localizedDescription)")
                
                switch error {
                case URLError.notConnectedToInternet:
                    return .notConnectedToInternet
                case let DecodingError.keyNotFound(key, context):
                    return .decodingKeyNotFoundError(key: key, context: context.debugDescription)
                case let DecodingError.valueNotFound(value, context):
                    return .decodingValueNotFoundError(key: value, context: context.debugDescription)
                case let DecodingError.typeMismatch(value, context):
                    return .decodingTypeMismatchError(key: value, context: context.debugDescription)
                case let DecodingError.dataCorrupted(context):
                    return .dataCorrupted(context)
                default:
                    debugPrint("error coming")
                    return .failedRequest
                }
            }
        
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
     
    }
}
