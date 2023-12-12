//
//  APIService.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 25/8/23.
//

import Foundation
import Combine
protocol APITrendingService {
    func getTrendingList() -> AnyPublisher<TrendingResults, APIError>
    func searchTrending(query: String, pageIndex: Int) -> AnyPublisher<TrendingResults, APIError>
}

protocol APIDetailsService {
    func getMovieCredit(for movieID: Int) -> AnyPublisher<MovieCredits, APIError>
    func loadCastProfiles(id: Int) -> AnyPublisher<CastProfile, APIError>
}
