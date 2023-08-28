//
//  Environment.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 28/8/23.
//

import Foundation
enum URLManager {
    static var apiBaseURL: URL {
        URL(string: "https://api.themoviedb.org/3/")!
    }
    
    static var apiKey: String {
        "98f157f12d9259aa25efa7a968ec355d"
    }
    
    static var apiToken: String {
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OGYxNTdmMTJkOTI1OWFhMjVlZmE3YTk2OGVjMzU1ZCIsInN1YiI6IjY0ZDlhZTczMDAxYmJkMDBjNmM4MGQ2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.daAlSowAw3X5oq7svCAdEIp6pQh_muDCzT6R9JUg6OA"
    }
}
