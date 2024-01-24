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
  var isFetching: Bool = false
  
  
  init(apiService: APIDetailsService, id: Int) {
    
    self.apiService = apiService
  }
  
  func getMovieCredit(for movieID: Int)  {
    isFetching = true
    apiService.getMovieCredit(for: movieID)
      .sink { completion in
        self.isFetching =  false
        switch completion {
        case .finished:
          print("successfully")
          self.loadCastProfiles()
        case .failure(let error):
          print("umable to fetch \(error)")
          self.errorMessage = error.message
        }
      } receiveValue: { [weak self] credits in
        self?.credits = credits
        self?.cast = credits.cast.sorted(by: { $0.order < $1.order })
      }.store(in: &subscriptions)
  }
  
  ///
  /// The loadCastProfiles function uses 'Publishers.MergeMany' to merge the individual publishers created for each cast member.
  /// The collect operator is then used to collect all the results into an array.
  /// This allows you to perform the requests concurrently.
  ///
  func loadCastProfiles ()  {
    let profilePublisher = Publishers.MergeMany(
      cast.map { member in
        apiService.loadCastProfiles(id: member.id)
          .mapError { error in
            if let apiError = error as? APIError {
              print(apiError)
            } else {
              print(error.localizedDescription)
            }
            return error
          }
      }
    )
    
    profilePublisher
      .collect()
      .sink { completion in
        switch completion {
        case .finished:
          print("successfully loadCastProfiles")
        case .failure(let error):
          print("umable to fetch \(error)")
          self.errorMessage = error.message
        }
      } receiveValue: { [weak self] profiles in
        self?.castProfiles = profiles
      }.store(in: &subscriptions)
  }
}

