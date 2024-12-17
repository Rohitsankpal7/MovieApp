//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 16/12/24.
//

import Foundation

protocol MovieRepository {
    func getMovies() async throws -> [Movie]
}
