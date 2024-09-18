//
//  MovieViewModel.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import Alamofire


class MovieViewModel {
    private let urlService = URLService.shared
    private let localStorage = LocalStorage.shared
    var movies: [Movie] = []
    var errorMessage: ((String) -> Void)?
    var didUpdateMovies: (() -> Void)?
    
    func fetchMovies(searchTerm: String? = nil) {
            if let localMovies = localStorage.fetchMovies() {
                self.movies = localMovies
                didUpdateMovies?()
            }

            let term = searchTerm ?? "star" // Default term if no search term is provided
            urlService.fetchMovies(searchTerm: term) { [weak self] result in
                switch result {
                case .success(let movieResponse):
                    self?.movies = movieResponse.results
                    self?.localStorage.saveMovies(movieResponse.results) // Save to local storage
                    self?.didUpdateMovies?()
                case .failure(let error):
                    self?.errorMessage?("Error: \(error.localizedDescription)")
                }
            }
        }
    
    
    
    func addToFavorites(movie: Movie) {
        LocalStorage.shared.saveToFavorites(movie: movie)
        self.didUpdateMovies?()
    }
    
    func removeFromFavorites(movie: Movie) {
        LocalStorage.shared.removeFromFavorites(movie: movie)
        self.didUpdateMovies?()
    }
    
    func isFavorite(movie: Movie) -> Bool {
        return LocalStorage.shared.isFavorite(movie: movie)
    }
}
