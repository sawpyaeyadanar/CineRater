//
//  CineRaterApp.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 9/8/23.
//

import SwiftUI

@main
struct CineRaterApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView(viewModel: MovieDiscoverViewModel(apiService: APIClient()))
                    .environmentObject(DataStore())
                    .tabItem {
                        Image(systemName: "popcorn")
                    }
                FavouriteMovies()
                .environmentObject(DataStore())
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                ContentView(viewModel: MovieDiscoverViewModel(apiService: APIClient()))
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                    }
            }
           
        }
    }
}
