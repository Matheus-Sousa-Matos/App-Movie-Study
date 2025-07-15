//
//  BannerView.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 14/07/25.
//


import SwiftUI

struct BannerView: View {
    let movies: [Movie]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle().fill(Color.gray.opacity(0.3))
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                        .overlay(
                            Text(movie.title)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(),
                            alignment: .bottomLeading
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    BannerView(movies: [Movie.mock, Movie.mock])
}
