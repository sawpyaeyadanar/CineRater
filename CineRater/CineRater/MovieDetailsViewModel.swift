//
//  MovieDetailsViewModel.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 22/8/23.
//

import Foundation
import SwiftUI

@MainActor
/*
 Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
 */
class MovieDetailsViewModel: ObservableObject {
    
    @Published var credits: MovieCredits?
    @Published var cast: [MovieCredits.Cast] = []
    @Published var castProfiles = [CastProfile]()
    
    func movieCredit(for movieID: Int) async {
            let urlString = "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US"
            if let url = URL(string: urlString) {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                        print("success")
                        let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
                        self.credits = credits
                        self.cast = credits.cast.sorted(by: { $0.order < $1.order })
                    } else {
                        print("error ")
                    }
                    
                   
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            } else {
                debugPrint("URL not found")
            }
    }
    
    func loadCastProfiles () async {
        
        for member in cast {
            let urlString = "https://api.themoviedb.org/3/person/\(member.id)?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US"
            if let url = URL(string: urlString) {
                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                        print("success")
                        let profile = try JSONDecoder().decode(CastProfile.self, from: data)
                        castProfiles.append(profile)
                    } else {
                        print("error ")
                    }
                   
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            } else {
                debugPrint("URL not found")
            }
        }
    }
}

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
    let profile_path: String
    
    var photoURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200/")
        return baseURL?.appending(path: profile_path )
    }
}
