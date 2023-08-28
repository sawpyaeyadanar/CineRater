//
//  MovieCredits.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 28/8/23.
//

import Foundation
struct MovieCredits: Decodable {
    let id: Int
    let cast: [Cast]
    
    struct Cast: Decodable, Identifiable {
        let name: String
        let id: Int
        let character: String
        let order: Int
    }
}

struct CastProfile: Decodable, Identifiable {
    let id: Int
    let name: String
    let profile_path: String?
    
    var photoURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200/")
        return baseURL?.appending(path: profile_path ?? "" )
    }
}
