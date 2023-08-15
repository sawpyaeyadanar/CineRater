//
//  TrendingCard.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 14/8/23.
//

import SwiftUI

struct TrendingCard: View {
    
    let trendingItem: Movie
    
    var body: some View {
        ZStack(alignment: .bottom){

            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 200)
            } placeholder: {
                Rectangle().fill(Color(red: 61/255, green: 61/255, blue: 88/255))
                    .frame(width: 340, height: 200)
                
            }
            
            VStack {
                HStack {
                    Text(trendingItem.title ?? "")
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", trendingItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            .background(Color(red: 61/255, green: 61/255, blue: 88/255))
        }
        .cornerRadius(10)

    }
}


struct TrendingCard_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCard(trendingItem: Movie(adult: false, id: 1, poster_path: "https://image.tmdb.org/t/p/w300//vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg", title: "Heart of Stone", vote_average: 7.2))
    }
}

