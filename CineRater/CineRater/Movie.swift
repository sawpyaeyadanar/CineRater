//
//  TrendingItem.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 14/8/23.
//

import Foundation
struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String?
    let vote_average: Float
    
    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w300/")
        return baseURL?.appending(path: poster_path )
    }
}
