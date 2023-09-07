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
                        Label("Trending", systemImage: "popcorn")
                    }
                FavouriteMovies()
                .environmentObject(DataStore())
                    .tabItem {
                        Label("Favourite", systemImage: "heart.fill")
                    }
                ContentView(viewModel: MovieDiscoverViewModel(apiService: APIClient()))
                    .tabItem {
                        Label("Bookmark", systemImage: "bookmark.fill")
                    }
            }
           
        }
    }
}
