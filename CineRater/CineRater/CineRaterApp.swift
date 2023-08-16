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
                ContentView()
                    .tabItem {
                        Image(systemName: "popcorn")
                    }
                ContentView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }
                ContentView()
                    .tabItem {
                        Image(systemName: "bookmark.fill")
                    }
            }
           
        }
    }
}
