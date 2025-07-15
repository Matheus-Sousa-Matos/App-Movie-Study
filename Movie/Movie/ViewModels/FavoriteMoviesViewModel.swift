//
//  FavoriteMoviesViewModel.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 11/07/25.
//

import SwiftUI

class FavoriteMoviesViewModel: ObservableObject {
    @Published var favorites: [Movie] = []

    init() {}

    func loadFavorites() {
        favorites = FavoriteManager.shared.fetchFavorites()
    }
}
