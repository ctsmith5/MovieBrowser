//
//  Movie.swift
//  MovieBrowser
//
//  Created by Colin Smith on 5/3/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let imagePath: String?
    let releaseDate: String?
    let ratingScore: Double
    let description: String
    let secondaryImage: String?
    let genreIDs: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imagePath = "poster_path"
        case secondaryImage = "backdrop_path"
        case releaseDate = "release_date"
        case ratingScore = "vote_average"
        case description = "overview"
        case genreIDs = "genre_ids"
    }
}


struct GenreResponse: Codable {
    let genres: [Genre]
}
struct Genre: Codable {
    let id: Int
    let name: String
}
