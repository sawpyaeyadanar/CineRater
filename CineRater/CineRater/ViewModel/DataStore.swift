//
//  DataStore.swift
//  CineRater
//
//  Created by Saw Pyae Yadanar on 4/9/23.
//

import Foundation

//@MainActor
class DataStore: ObservableObject {
    @Published var movies:[Movie] = []
    @Published var appError: ErrorType? = nil
    @Published var showErrorAlert = false
    @Published var filterText = "" {
        didSet {
            filterMovies()
        }
    }
    
    @Published var filteredMovies: [Movie] = []
    init() {
        print(FileManager.docDirURL.path)
    }
    
    private func filterMovies() {
        if !filterText.isEmpty {
            filteredMovies = movies.filter{
                ($0.title?.lowercased() ?? "").contains(filterText.lowercased())
            }
        } else {
            filteredMovies = movies
        }
    }
    
    
    func newMovie() {
        addMovie(Movie(adult: true, id: 1, poster_path: "", title: "", vote_average: 0.0, overview: ""))
    }
    
    func addMovie(_ movie: Movie) {
        movies.append(movie)
        saveMoviesThrows()
        filteredMovies = movies
    }
    
    func updateMovie(_ movie: Movie) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id}) else { return }
        movies[index] = movie
        saveMoviesThrows()
    }
    
    func deleteMovie(at indexSet: IndexSet) {
        movies.remove(atOffsets: indexSet)
        saveMoviesThrows()
    }
    
    func deleteTodo(_ movie: Movie) {
        if let index = movies.firstIndex(where: {$0.id == movie.id}) {
            movies.remove(at: index)
            saveMoviesThrows()
            filterMovies()
        }
    }
    
    func loadMovies() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    movies = try decoder.decode([Movie].self, from: data)
                } catch {
                    appError = ErrorType(error: .readError)
                    showErrorAlert = true
                }
                
            case .failure(let error):
                appError = ErrorType(error: error)
                showErrorAlert = true
                print(error.localizedDescription)
            }
        }
    }
    
    func loadToDos2() {
        do {
            let data = try FileManager().readDocument(docName: fileName)
            let decoder = JSONDecoder()
            do {
                movies = try decoder.decode([Movie].self, from: data)
                filteredMovies = movies
            } catch {
                appError = ErrorType(error: .readError)
                showErrorAlert = true
            }
        } catch let error {
            appError = ErrorType(error: error as! LocalError)
            showErrorAlert = true
            print(error.localizedDescription)
        }
    }
    
    func saveMovie() {
        print("Saving movies to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movies)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    appError = ErrorType(error: .saveError)
                    showErrorAlert = true
                }
            }
        } catch let error {
            appError = ErrorType(error: error as! LocalError)
            showErrorAlert = true
            print(error.localizedDescription)
        }
    }
    
    func saveMoviesThrows() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movies)
            let jsonString = String(decoding: data, as: UTF8.self)
            do {
                try FileManager().saveDocument(contents: jsonString, docName: fileName)
            } catch let error {
                print(error.localizedDescription)
                appError = ErrorType(error: .saveError)
                showErrorAlert = true
            }
        } catch let error {
            appError = ErrorType(error: error as! LocalError)
            showErrorAlert = true
            print(error.localizedDescription)
        }
        
    }
}
