//
//  TMDBService.swift
//  ListMovie
//
//  Created by Matheus de Sousa Matos on 26/06/25.
//

import Foundation

protocol TMDBServiceProtocol {
    func fetchMovieList(typeList: String, completion: @escaping (Result<ListPopularMovies, Error>) -> Void)
}

final class TMDBService: TMDBServiceProtocol {
    public static let shared = TMDBService()
    private init() {}
    
    public func fetchMovieList(typeList: String, completion: @escaping (Result<ListPopularMovies, Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(typeList)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlODNjMzYzZjBlMThjY2M1OTFhMmJiYjBkYmQ5MjI2MSIsIm5iZiI6MTY1OTEwNTEwMC4xMDYsInN1YiI6IjYyZTNlZjRjMGU1YWJhMDA1YjYwMWYwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PPRge1ZKSneduHVNQuQ3nkJZatW7LGmVokwx0EXzzu4"
        ]


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                //completion(.failure(.requestFailed(error)))
                print("Erro: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                //completion(.failure(.noData))
                return
            }

            do {
                print(String(decoding: data, as: UTF8.self))
                
                let listPopularMovies = try JSONDecoder().decode(ListPopularMovies.self, from: data)
                completion(.success(listPopularMovies))
            } catch {
                print(String(decoding: data, as: UTF8.self))
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
}

class MockTMDBService: TMDBServiceProtocol {
    func fetchMovieList(typeList: String, completion: @escaping (Result<ListPopularMovies, Error>) -> Void) {
        completion(.success(ListPopularMovies.mock))
    }
}
