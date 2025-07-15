//
//  FavoriteView.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 11/07/25.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteMoviesViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.favorites) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        HStack(alignment: .top, spacing: 12) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath)")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(8)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(movie.title)
                                    .font(.headline)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favoritos")
            .onAppear {
                viewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    FavoriteView()
}

