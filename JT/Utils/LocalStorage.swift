//
//  LocalStorage.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import Foundation


class LocalStorage {
    static let shared = LocalStorage()
    
    func saveMovies(_ movies: [Movie]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movies)
            UserDefaults.standard.set(data, forKey: "savedMovies")
        } catch {
            print("Failed to save movies:", error)
        }
    }
    
    func fetchMovies() -> [Movie]? {
        guard let data = UserDefaults.standard.data(forKey: "savedMovies") else { return nil }
        let decoder = JSONDecoder()
        do {
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            print("Failed to decode movies from local storage:", error)
            return nil
        }
    }
    
    
    // fav
    private let favoritesKey = "favoriteMovies"
       
       func saveToFavorites(movie: Movie) {
           var favorites = fetchFavorites()
           favorites.append(movie)
           if let data = try? JSONEncoder().encode(favorites) {
               UserDefaults.standard.set(data, forKey: favoritesKey)
           }
       }
       
       func fetchFavorites() -> [Movie] {
           guard let data = UserDefaults.standard.data(forKey: favoritesKey),
                 let favorites = try? JSONDecoder().decode([Movie].self, from: data) else {
               return []
           }
           return favorites
       }
       
       func removeFromFavorites(movie: Movie) {
           var favorites = fetchFavorites()
           if let index = favorites.firstIndex(where: { $0.trackName == movie.trackName }) {
               favorites.remove(at: index)
               if let data = try? JSONEncoder().encode(favorites) {
                   UserDefaults.standard.set(data, forKey: favoritesKey)
               }
           }
       }
       
       func isFavorite(movie: Movie) -> Bool {
           return fetchFavorites().contains(where: { $0.trackName == movie.trackName })
       }
}
