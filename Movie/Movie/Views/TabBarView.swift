//
//  TabBarView.swift
//  ListMovie
//
//  Created by Matheus de Sousa Matos on 06/07/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MovieHomeView()
                .tabItem {
                    Label("Início", systemImage: "house.fill")
                }

            FavoriteView()
                .tabItem {
                    Label("Favoritos", systemImage: "heart.fill")
                }
        }
    }
}
