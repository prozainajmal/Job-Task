//
//  Movie.swift
//  JT
//
//  Created by Zany on 18/09/2024.
//

import Foundation

struct Movie: Codable {
    let artworkUrl100: String?
    let currency: String?
    let trackPrice: Double?
    let trackName: String?

    enum CodingKeys: String, CodingKey {
        case  trackName , artworkUrl100 ,trackPrice , currency
    }
}
