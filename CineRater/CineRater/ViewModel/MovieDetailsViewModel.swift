//
//  MovieDetailsViewModel.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 22/8/23.
//

import Foundation
import SwiftUI
import Combine
import Observation
//@MainActor //-> applicable for using task
/*
 Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
 */
@Observable class MovieDetailsViewModel {
    
    var credits: MovieCredits?
    var cast: [MovieCredits.Cast] = []
    var castProfiles = [CastProfile]()
    var errorMessage: String?
    private let apiService: APIDetailsService
    private var subscriptions: Set<AnyCancellable> = []
    var isFetching: Bool?
    
    
    init(apiService: APIDetailsService, id: Int) {
        
        self.apiService = apiService
        getMovieCredit(for: id)
    }
    
    func getMovieCredit(for movieID: Int)  {
        isFetching = true
        apiService.getMovieCredit(for: movieID)
            .sink { completion in
                self.isFetching =  false
                switch completion {
                case .finished:
                    print("successfully")
                case .failure(let error):
                    print("umable to fetch \(error)")
                    self.errorMessage = error.message
                }
            } receiveValue: { [weak self] credits in
                self?.credits = credits
                self?.cast = credits.cast.sorted(by: { $0.order < $1.order })
            }.store(in: &subscriptions)
    }
    
    func loadCastProfiles () async {
        
        for member in cast {
            apiService.loadCastProfiles(id: member.id)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("successfully")
                    case .failure(let error):
                        print("umable to fetch \(error)")
                        self.errorMessage = error.message
                    }
                } receiveValue: { [weak self] profile in
                    self?.castProfiles.append(profile)
                }.store(in: &subscriptions)
           
        }
    }
}

