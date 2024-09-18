//
//  URLService.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import Foundation
import Alamofire

class URLService {
    static let shared = URLService()
    
    
      func fetchMovies(searchTerm: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
          let searchTermEncoded = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchTerm
          let url = "https://itunes.apple.com/search?term=\(searchTermEncoded)&country=au&media=movie"
          
          AF.request(url, method: .get).responseData { response in
              switch response.result {
              case .success(let data):
                  do {
                      let decoder = JSONDecoder()
                      let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                      completion(.success(movieResponse))
                  } catch {
                      completion(.failure(error))
                  }
              case .failure(let error):
                  completion(.failure(error))
              }
          }
      }
}
