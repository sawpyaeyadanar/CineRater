//
//  FavouriteMovies.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 4/9/23.
//

import SwiftUI

struct FavouriteMovies: View {
    @EnvironmentObject var dataStore: DataStore
    //@State var movies: [Movie]
    var body: some View {

        NavigationView {
            List {
                ForEach(dataStore.movies) { movie in
                    TrendingCard(trendingItem: movie, clickFavourite: { isFavourite in
                        isFavourite ? dataStore.addMovieSubject.send(movie): dataStore.removeMovieSubject.send(movie)
                        
                    })
                        .background(Color(red: 39/255, green: 40/255, blue: 59/255))
                }
                .onDelete(perform: dataStore.removeMovieByIndexSubject.send(_:))
            }
            
            .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("Trending Movies", displayMode: .inline)
        }

        .task {
            if FileManager().docExist(named: fileName) {
                dataStore.loadToDos2()
            }
        }
        .alert("File Error",
               isPresented: $dataStore.showErrorAlert,
               presenting: dataStore.appError) { appError in
            appError.button
        } message: { appError in
            Text(appError.message)
        }
    }
}

struct FavouriteMovies_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMovies()
//        FavouriteMovies(movies: [
//            Movie(adult: true, id: 1, poster_path: "", title: "TITLE 1", vote_average: 2.3, overview: "title 1"),
//            Movie(adult: true, id: 1, poster_path: "", title: "TITLE 1", vote_average: 2.3, overview: "title 1"),
//            Movie(adult: true, id: 1, poster_path: "", title: "TITLE 1", vote_average: 2.3, overview: "title 1")
//        ])
    }
}
