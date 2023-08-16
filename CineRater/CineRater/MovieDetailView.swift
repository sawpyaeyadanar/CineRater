//
//  MovieDetailView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 15/8/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: movie.backdropURL)
                    .frame(height: 200)
                Spacer()
            }
            ScrollView {
                Spacer()
                    .frame(height: 200)
                Text(movie.title ?? "")
                Text(movie.overview)
            }
            
        }
        .background(.yellow)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .mock)
    }
}
