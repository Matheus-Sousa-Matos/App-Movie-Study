//
//  MovieSection.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 14/07/25.
//

import SwiftUI

struct MovieSection: View {
    let title: String
    let movies: [Movie]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .bold()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            MovieCardHorizontal(movie: movie)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MovieSection(title: "Popular", movies: [Movie.mock, Movie.mock])
}
