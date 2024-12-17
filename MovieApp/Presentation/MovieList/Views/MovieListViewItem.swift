//
//  MovieListViewItem.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 16/12/24.
//

import SwiftUI

struct MovieItemView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.fullPosterURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 150)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("Rating: \(String(format: "%.1f", movie.voteAverage))")
                    .font(.subheadline)
                Text("Release: \(movie.releaseDate)")
                    .font(.subheadline)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}
