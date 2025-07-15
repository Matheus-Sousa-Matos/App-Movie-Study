//
//  ListPopularMovies.swift
//  ListMovie
//
//  Created by Matheus de Sousa Matos on 03/07/25.
//

import Foundation

struct ListPopularMovies: Codable {
    let page: Int
    let results: [Movie]?
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension ListPopularMovies {    
    static var mock: ListPopularMovies {
        ListPopularMovies(page: 1, results: [Movie.mock], totalPages: 1, totalResults: 1)
    }
}
