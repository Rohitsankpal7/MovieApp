//
//  Untitled.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 18/12/24.
//

import Foundation
@testable import MovieApp

class MockMovieRepository: MovieRepository {
    var mockMovies: [Movie] = []
    var mockError: Error?
    
    func getMovies() async throws -> [Movie] {
        if let error = mockError {
            throw error
        }
        return mockMovies
    }
}
