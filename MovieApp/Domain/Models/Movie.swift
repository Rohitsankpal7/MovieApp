//
//  Movie.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 16/12/24.
//
import Foundation

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    // Computed property for full poster URL
    var fullPosterURL: String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
} 
