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
    let overview: String
    
    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200/")
        return baseURL?.appending(path: poster_path )
    }
    
    static var mock: Movie {
        Movie(adult: false, id: 2321, poster_path: "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.8, overview: "An intelligence operative for a shadowy global peacekeeping agency races to stop a hacker from stealing its most valuable — and dangerous — weapon.")
    }
}
