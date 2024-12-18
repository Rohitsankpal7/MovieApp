//
//  MovieListViewModelTests.swift
//  MovieAppTests
//
//  Created by Rohit Sankpal on 18/12/24.
//

import XCTest
@testable import MovieApp

@MainActor
final class MovieListViewModelTests: XCTestCase {
    private var sut: MovieListViewModel!
    private var mockRepository: MockMovieRepository!
    
    // MARK: - Test Lifecycle
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        sut = MovieListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Test Data
    
    private let mockMoviesData: [Movie] = [
        Movie(
            id: 1,
            title: "Test Movie 1",
            posterPath: "Test Overview 1",
            releaseDate: "2024-03-20",
            voteAverage: 8.5,
            overview: ""
        ),
        Movie(
            id: 2,
            title: "Test Movie 2",
            posterPath: "Test Overview 2",
            releaseDate: "2024-03-21",
            voteAverage: 7.5,
            overview: ""
        )
    ]
    
    // MARK: - Tests
    
    func test_loadMovies_success() {
        // Given
        mockRepository.mockMovies = mockMoviesData
        let expectation = XCTestExpectation(description: "Movies loaded")
        
        // When
        sut.loadMovies()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.movies.count, 2)
            XCTAssertEqual(self.sut.movies[0].id, self.mockMoviesData[0].id)
            XCTAssertEqual(self.sut.movies[1].title, self.mockMoviesData[1].title)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertNil(self.sut.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_loadMovies_failure() {
        // Given
        let expectedError = NSError(domain: "TestError", code: -1)
        mockRepository.mockError = expectedError
        let expectation = XCTestExpectation(description: "Error handled")
        
        // When
        sut.loadMovies()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.sut.movies.isEmpty)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertNotNil(self.sut.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_loadMovies_preventsConcurrentCalls() {
        // Given
        mockRepository.mockMovies = mockMoviesData
        sut.isLoading = true
        
        // When
        sut.loadMovies()
        
        // Then
        XCTAssertTrue(sut.movies.isEmpty) // Should not load movies when already loading
    }
}
