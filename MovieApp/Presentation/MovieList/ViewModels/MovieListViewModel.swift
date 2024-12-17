//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 16/12/24.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func loadMovies() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                movies = try await repository.getMovies()
            } catch {
                self.error = error
                print("Error loading movies: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
