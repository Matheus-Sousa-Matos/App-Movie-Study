//
//  MovieTests.swift
//  MovieTests
//
//  Created by Matheus de Sousa Matos on 06/07/25.
//

import XCTest
@testable import Movie

final class MovieHomeViewModelTests: XCTestCase {
    
    var viewModel: MovieHomeViewModel!
    var mockService: MockTMDBService!

    override func setUp() {
        super.setUp()
        mockService = MockTMDBService()
        viewModel = MovieHomeViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadMovies_PopulatesAllCategories() {
        // Given
        let expectationPopular = XCTestExpectation(description: "Popular movies loaded")
        let expectationTopRated = XCTestExpectation(description: "Top Rated movies loaded")
        let expectationNowPlaying = XCTestExpectation(description: "Now Playing movies loaded")
        let expectationUpcoming = XCTestExpectation(description: "Upcoming movies loaded")

        // When
        viewModel.loadMovies()

        // Verificações assíncronas
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.viewModel.popular == ListPopularMovies.mock.results {
                expectationPopular.fulfill()
            }
            if self.viewModel.topRated == ListPopularMovies.mock.results {
                expectationTopRated.fulfill()
            }
            if self.viewModel.nowPlaying == ListPopularMovies.mock.results {
                expectationNowPlaying.fulfill()
            }
            if self.viewModel.upcoming == ListPopularMovies.mock.results {
                expectationUpcoming.fulfill()
            }
        }

        wait(for: [
            expectationPopular,
            expectationTopRated,
            expectationNowPlaying,
            expectationUpcoming
        ], timeout: 1.0)
    }
}
