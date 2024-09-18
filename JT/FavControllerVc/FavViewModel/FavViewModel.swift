//
//  FavViewModel.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import Foundation
class FavViewModel {
    
    var movies: [Movie] = []
    var didUpdateMovies: (() -> Void)?
    var errorMessage: ((String) -> Void)?
    
    func fetchMovies() {
        // Fetch movies from API and update movies array
        // For now let's assume this part is working.
        movies = LocalStorage.shared.fetchFavorites()
        self.didUpdateMovies?()
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
