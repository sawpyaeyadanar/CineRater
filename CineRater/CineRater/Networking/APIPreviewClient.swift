//
//  APIPreviewClient.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 28/8/23.
//

import Foundation
import Combine

struct APIPreviewClient: APITrendingService {
    
    
    func searchTrending(query: String, pageIndex: Int) -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "trending", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load Trending") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
    func getTrendingList() -> AnyPublisher<TrendingResults, APIError> {
        guard let url = Bundle.main.url(forResource: "trending", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let trendingResults = try? JSONDecoder().decode(TrendingResults.self, from: data)
            
        else { fatalError("Unable to Load Trending") }
        return Just(trendingResults)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    
}

extension APIPreviewClient: APIDetailsService {
    
    func loadCastProfiles(id: Int) -> AnyPublisher<CastProfile, APIError> {
        guard let url = Bundle.main.url(forResource: "person", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let castProfile = try? JSONDecoder().decode(CastProfile.self, from: data)
            
        else { fatalError("Unable to Load Profile") }
        return Just(castProfile)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func getMovieCredit(for movieID: Int) -> AnyPublisher<MovieCredits, APIError> {
    
        guard let url = Bundle.main.url(forResource: "credits", withExtension: "json"),
        let data = try? Data(contentsOf: url),
              let credits = try? JSONDecoder().decode(MovieCredits.self, from: data)
            
        else { fatalError("Unable to Load Credits") }
        return Just(credits)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
