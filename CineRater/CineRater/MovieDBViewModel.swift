//
//  MovieDBViewModel.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 14/8/23.
//

import Foundation

@MainActor
class MovieDBViewModel: ObservableObject {
    
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    static let apiKey = "98f157f12d9259aa25efa7a968ec355d"
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OGYxNTdmMTJkOTI1OWFhMjVlZmE3YTk2OGVjMzU1ZCIsInN1YiI6IjY0ZDlhZTczMDAxYmJkMDBjNmM4MGQ2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.daAlSowAw3X5oq7svCAdEIp6pQh_muDCzT6R9JUg6OA"
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=\(MovieDBViewModel.apiKey)")!
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("success")
                    let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                    trending = trendingResults.results
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
            
        }
    }
    
    func searchItem(term: String) {
        Task {
            
            if let termEncoded = term.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
                let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDBViewModel.apiKey)&language=en-US&page=1&include_adult=false&query=\(termEncoded)"
                if let url = URL(string: urlString) {
                    do {
                        let (data, response) = try await URLSession.shared.data(from: url)
                        if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                            print("success")
                            let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                            searchResults = trendingResults.results
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
            } else {
               debugPrint("Result not found")
            }
        }
    }
}
