//
//  MovieDetailView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 15/8/23.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var model : MovieDetailsViewModel
    
    let movie: Movie
    var body: some View {
        let _ = Self._printChanges()
        ZStack {
            Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL, content: { img in
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: 400)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        
                    }, placeholder: {
                        ProgressView()
                    })
                    Spacer()
                }
            }
          if model.isFetching {
            ProgressView()
          }
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: 400)
                    HStack {
                        Text(movie.title ?? "")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        Spacer()
                        // ratings here
                    }
                    
                    HStack {
                        //genre tags
                        //running time
                        
                    }
                    
                    HStack {
                        Text("About film")
                            .foregroundColor(.white)
                        Spacer()
                        // see all button
                    }
                    Text(movie.overview)
                        .lineLimit(2)
                        .foregroundColor(.white)
                    HStack {
                        Text("Cast & Crew")
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        Spacer()
                        // see all button
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                             let profiles = model.castProfiles
                            ForEach(profiles) { profile in
                                CastView(cast:  profile)
                            }
                        }
                    }
                    
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading, content: {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
            .padding(.leading)
            
        })
        .toolbar(.hidden, for: .navigationBar)
//        .task { // adds asynchronous task to perform before this view appear
//           model.getMovieCredit(for: movie.id)
//        }
        .onAppear {
          model.getMovieCredit(for: movie.id)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {

    static var previews: some View {
        MovieDetailView(model: MovieDetailsViewModel(apiService: APIPreviewClient(), id: 1), movie: .mock)
    }
}


