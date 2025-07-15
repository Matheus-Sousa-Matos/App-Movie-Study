//
//  Movie.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 12/07/25.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let genreIDs: [Int]
    let adult: Bool
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    
    var isFavorite: Bool {
        FavoriteManager.shared.isFavorite(movieId: id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case genreIDs = "genre_ids"
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

extension Movie {
    static var mock: Movie {
        Movie(
            id: 101,
            genreIDs: [28, 12, 878],
            adult: false,
            backdropPath: "/wqfu3bPLJaEWJVk3QOm0rKhxf1A.jpg",
            originalLanguage: "en",
            originalTitle: "The Old Guard 2",
            overview: "Andy and her team of immortal warriors fight with renewed purpose as they face a powerful new foe threatening their mission to protect humanity.",
            popularity: 9876.5,
            posterPath: "/xyzPoster.jpg",
            releaseDate: "2025-07-10",
            title: "The Old Guard 2",
            voteAverage: 8.7
        )
    }
}
