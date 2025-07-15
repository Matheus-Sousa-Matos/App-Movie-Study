//
//  Persistence.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 06/07/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Movie")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Erro ao carregar Core Data: \(error)")
            }
        }
    }
}

class FavoriteManager {
    static let shared = FavoriteManager()

    private let context = PersistenceController.shared.container.viewContext

    func isFavorite(movieId: Int) -> Bool {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieId)

        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }

    func addToFavorites(movie: Movie) {
        let favorite = FavoriteMovie(context: context)
        favorite.id = Int64(movie.id)
        favorite.title = movie.title
        favorite.posterPath = movie.posterPath
        favorite.backdropPath = movie.backdropPath
        favorite.overview = movie.overview
        favorite.releaseDate = movie.releaseDate
        favorite.voteAverage = movie.voteAverage
        try? context.save()
    }

    func removeFromFavorites(movieId: Int) {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieId)

        if let favorites = try? context.fetch(request) {
            for fav in favorites {
                context.delete(fav)
            }
            try? context.save()
        }
    }
    
    func fetchFavorites() -> [Movie] {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()

        guard let favorites = try? context.fetch(request) else {
            return []
        }
                
        return favorites.map {
            Movie(
                id: Int($0.id),
                genreIDs: [],
                adult: false,
                backdropPath: $0.backdropPath ?? "",
                originalLanguage: "en",
                originalTitle: $0.title ?? "",
                overview: $0.overview ?? "",
                popularity: 0.0,
                posterPath: $0.posterPath ?? "",
                releaseDate: $0.releaseDate ?? "",
                title: $0.title ?? "",
                voteAverage: $0.voteAverage
            )
        }
    }
}
