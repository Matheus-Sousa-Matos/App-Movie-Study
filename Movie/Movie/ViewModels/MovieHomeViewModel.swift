//
//  MovieHomeViewModel.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 04/07/25.
//

import SwiftUI

enum TypeListMovie: String {
    case topRated = "top_rated"
    case popular = "popular"
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
}

class MovieHomeViewModel: ObservableObject {
    private let service: TMDBServiceProtocol
    
    @Published var popular: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var nowPlaying: [Movie] = []
    @Published var upcoming: [Movie] = []

    init(service: TMDBServiceProtocol = TMDBService.shared) {
        self.service = service
    }
    
    public func loadMovies() {
        loadPopularMovies()
        loadUpcomingMovies()
        loadTopRatedMovies()
        loadNowPlayingMovies()
    }

    private func loadPopularMovies() {
        service.fetchMovieList(typeList: TypeListMovie.popular.rawValue) { result in
            if case let .success(list) = result, let movies = list.results {
                DispatchQueue.main.async {
                    self.popular = movies
                }
            }
        }
    }

    private func loadNowPlayingMovies() {
        service.fetchMovieList(typeList: TypeListMovie.nowPlaying.rawValue) { result in
            if case let .success(list) = result, let movies = list.results {
                DispatchQueue.main.async {
                    self.nowPlaying = movies
                }
            }
        }
    }

    private func loadUpcomingMovies() {
        service.fetchMovieList(typeList: TypeListMovie.upcoming.rawValue) { result in
            if case let .success(list) = result, let movies = list.results {
                DispatchQueue.main.async {
                    self.upcoming = movies
                }
            }
        }
    }

    private func loadTopRatedMovies() {
        service.fetchMovieList(typeList: TypeListMovie.topRated.rawValue) { result in
            if case let .success(list) = result, let movies = list.results {
                DispatchQueue.main.async {
                    self.topRated = movies
                }
            }
        }
    }
}
