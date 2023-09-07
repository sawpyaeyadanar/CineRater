//
//  CineRaterApp.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 9/8/23.
//

import SwiftUI

enum Screens {
    case trending
    case favourite
    case bookmark
}

final class TabBarRouter: ObservableObject {
    @Published var screen: Screens = .trending
    
    func changeScreen(to screen: Screens) {
        debugPrint("Current Screen is \(screen)")
        self.screen = screen
    }
}

@main
struct CineRaterApp: App {
    @StateObject private var tabBarRouter = TabBarRouter()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabBarRouter.screen) {
                
                ContentView(viewModel: MovieDiscoverViewModel(apiService: APIClient()))
                    .tag(Screens.trending)
                    .environmentObject(tabBarRouter)
                    .environmentObject(DataStore())
                    .tabItem {
                        Label("Trending", systemImage: "popcorn")
                    }
                FavouriteMovies()
                    .tag(Screens.favourite)
                    .environmentObject(tabBarRouter)
                    .environmentObject(DataStore())
                    .tabItem {
                        Label("Favourite", systemImage: "heart.fill")
                    }
                ContentView(viewModel: MovieDiscoverViewModel(apiService: APIClient()))
                    .tag(Screens.bookmark)
                    .tabItem {
                        Label("Bookmark", systemImage: "bookmark.fill")
                    }
            }
            .onChange(of: tabBarRouter.screen) { newValue in
                debugPrint("New Value ", newValue)
            }
           
        }
    }
}
