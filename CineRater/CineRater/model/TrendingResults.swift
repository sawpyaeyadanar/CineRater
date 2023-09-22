//
//  TrendingResults.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 14/8/23.
//

import Foundation
struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case total_pages = "totalPages"
        case total_results = "totalResults"
    }
}
