//
//  ContentView.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    
    //@EnvironmentObject var mainEnv: MainEnvironment
    @EnvironmentObject var tabBarRouter: TabBarRouter
    @EnvironmentObject var dataStore: DataStore
    @StateObject var viewModel : MovieDiscoverViewModel
    @State var searchText = ""
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack {
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                }
            } else {
                ScrollView {
                    if searchText.isEmpty {
                        if viewModel.trending.isEmpty {
                            Text("No results")
                        } else {
                            HStack {
                                Text("Trending")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            .padding(.horizontal)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    
                                    ForEach(viewModel.trending) { movie in
//                                        TrendingCard(trendingItem: movie, clickFavourite: { isFavourite in
//
//                                            if isFavourite {
//                                                dataStore.addMovieSubject.send(movie)
//                                            } else {
//                                               dataStore.removeMovieSubject.send(movie)
//                                            }
//                                        })
                                        NavigationLink {

                                            MovieDetailView(model:  MovieDetailsViewModel(apiService: APIClient(),
                                                                                          id: movie.id), movie: movie)
                                        } label: {
                                            TrendingCard(trendingItem: movie, clickFavourite: { isFavourite in
                                                
                                                if isFavourite {
                                                    dataStore.addMovieSubject.send(movie)
                                                } else {
                                                   dataStore.removeMovieSubject.send(movie)
                                                }
                                            })
                                        }
                                        /*
                                            .onTapGesture {
                                                self.itemTapped(movie)
                                                //tabBarRouter.changeScreen(to: .favourite)
                                            }
                                         */
                                    }
                                    
                                }
                                .padding(.horizontal)
                                
                            }
                           
                        }
                    } else {
                        LazyVStack {
                            ForEach(viewModel.searchResults) { item in
                                HStack {
                                    AsyncImage(url: item.backdropURL) { img in
                                        img
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 120)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 80, height: 120)
                                    }
                                    .clipped()
                                    .cornerRadius(10)
                                    VStack(alignment: .leading) {
                                        Text(item.title ?? "")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        HStack {
                                            Image(systemName: "hand.thumbsup.fill")
                                                .foregroundColor(.yellow)
                                            Text(String(format: "%.1f", item.vote_average))
                                            Spacer()
                                        }
                                        .foregroundColor(.yellow)
                                        .fontWeight(.heavy)
                                    }
                                    Spacer()
                                    
                                }
                                .padding()
                                .background(Color(red: 61/255, green: 61/255, blue: 88/255))
                                .cornerRadius(20)
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 39/255, green: 40/255, blue: 59/255).ignoresSafeArea())
                //.clipped()
                /** use clip to make sure that it doesn't overflow where it doesn't need to*/
            }
            
        }

        .searchable(text: $searchText,
                    prompt:  Text("search movie"))
        
        .onChange(of: searchText) { newValue in
            if newValue.count > 2 {
                viewModel.searchItem(term: newValue, pageIndex: 1)
            }
        }
        .onAppear {
            // viewModel.loadTrending()
            viewModel.searchItem(term: searchText, pageIndex: 1)
        }
        
        
        
    }
    
    func itemTapped(_ item: Movie) {
        print("Item tapped: \(item)")
        dataStore.addMovieSubject.send(item)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MovieDiscoverViewModel(apiService: APIPreviewClient()))
    }
}

