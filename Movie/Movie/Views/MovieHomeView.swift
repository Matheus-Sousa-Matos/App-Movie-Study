//
//  MovieHomeView.swift
//  Movie
//
//  Created by Matheus de Sousa Matos on 04/07/25.
//

import SwiftUI

struct MovieHomeView: View {
    @StateObject private var viewModel = MovieHomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    BannerView(movies: viewModel.nowPlaying)
                    
                    MovieSection(title: "Top Rated", movies: viewModel.topRated)
                    MovieSection(title: "Popular", movies: viewModel.popular)
                    MovieSection(title: "Upcoming", movies: viewModel.upcoming)
                }
                .padding(.horizontal)
            }
            .listStyle(.plain)
            .navigationTitle("Início")
            .onAppear {
                viewModel.loadMovies()
            }
        }
    }
}

#Preview {
    MovieHomeView()
}
