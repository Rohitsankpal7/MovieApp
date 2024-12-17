//
//  MovieRepositoryImplementation.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 16/12/24.
//

import Foundation

class MovieRepositoryImpl: MovieRepository {
    private let apiService: MovieAPIService
    
    init(apiService: MovieAPIService) {
        self.apiService = apiService
    }
    
    func getMovies() async throws -> [Movie] {
        return try await apiService.fetchMovies()
    }
}
