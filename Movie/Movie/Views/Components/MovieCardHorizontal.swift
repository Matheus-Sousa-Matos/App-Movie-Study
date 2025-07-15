//
//  MovieCardHorizontal.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 14/07/25.
//

import SwiftUI

struct MovieCardHorizontal: View {
    var movie: Movie

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { image in
                image
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fill)
            } placeholder: {
                Rectangle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 120, height: 180)
            .cornerRadius(10)

            Text(movie.title)
                .font(.caption)
                .foregroundStyle(.black)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}

#Preview {
    MovieCardHorizontal(movie: Movie.mock)
}
