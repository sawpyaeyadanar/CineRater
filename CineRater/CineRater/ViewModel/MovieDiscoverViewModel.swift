//
//  MovieDiscoverViewModel.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 14/8/23.
//

import Foundation
import Combine

@MainActor
class MovieDiscoverViewModel: ObservableObject {
    
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var errorMessage: String?
    private let apiService: APITrendingService
    private var subscriptions: Set<AnyCancellable> = []
    var isFetching: Bool?
    
    init(apiService: APITrendingService) {
        
        self.apiService = apiService
        loadTrending()
    }
    
    func loadTrending() {
        isFetching = true
        apiService.getTrendingList()
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    print("successfully")
                case .failure(let error):
                    print("umable to fetch \(error)")
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.trending = trendingResults.results
            }.store(in: &subscriptions)
/*
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=\(URLManager.apiKey)")!
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
        */
    }
    
    func searchItem(term: String, pageIndex: Int) {
        apiService.searchTrending(query: term, pageIndex: pageIndex)
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    print("search item successfully")
                case .failure(let error):
                    print("umable to fetch \(error)")
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] trendingResults in
                self?.searchResults = trendingResults.results
            }.store(in: &subscriptions)
        
       /*
        Task {
            
            if let termEncoded = term.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
                let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(URLManager.apiKey)&language=en-US&page=1&include_adult=false&query=\(termEncoded)"
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
        */
    }
    
}

