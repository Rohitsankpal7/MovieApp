//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 17/12/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Movie Poster
                AsyncImage(url: URL(string: movie.fullPosterURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(2/3, contentMode: .fit)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    // Title and Release Date
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Release Date: \(movie.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Rating
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", movie.voteAverage))
                    }
                    
                    // Overview
                    Text("Overview")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(movie.overview)
                        .font(.body)
                        .lineSpacing(4)
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
