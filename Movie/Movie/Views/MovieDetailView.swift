//
//  MovieDetailView.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 10/07/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State private var isFavorite: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 300)
                                .clipped()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: geometry.size.width, height: 300)
                        }

                        Button(action: {
                            isFavorite.toggle()
                            if isFavorite {
                                FavoriteManager.shared.addToFavorites(movie: movie)
                            } else {
                                FavoriteManager.shared.removeFromFavorites(movieId: movie.id)
                            }
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(isFavorite ? .red : .white)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                        .padding(12)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(movie.title)
                            .font(.title)
                            .bold()

                        HStack {
                            Text("Lançamento: \(movie.releaseDate)")
                            Spacer()
                            Text("⭐️ \(String(format: "%.1f", movie.voteAverage))/10")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                        Divider()

                        Text(movie.overview)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width * 0.9)
                }
                .padding(.bottom)
                .frame(width: geometry.size.width)
            }
            .onAppear {
                isFavorite = FavoriteManager.shared.isFavorite(movieId: movie.id)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock)
}
