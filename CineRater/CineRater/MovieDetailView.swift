//
//  MovieDetailView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 15/8/23.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let movie: Movie
    var body: some View {
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
            ScrollView {
                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: 400)
                    HStack {
                        Text(movie.title ?? "")
                            .font(.title)
                            .fontWeight(.heavy)
                        Spacer()
                        // ratings here
                    }
                    
                    HStack {
                        //genre tags
                        //running time
                        
                    }
                    
                    HStack {
                        Text("About film")
                        Spacer()
                        // see all button
                    }
                    Text(movie.overview)
                        .lineLimit(2)
                        .foregroundColor(.secondary)
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
        /*
        // Mark:- replace default navigation back
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }

            }
        }
        */
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .mock)
    }
}
