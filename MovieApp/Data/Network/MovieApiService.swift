//
//  MovieApiService.swift
//  MovieApp
//
//  Created by Rohit Sankpal on 16/12/24.
//

import Foundation

class MovieAPIService {
    private let apiKey = "06d4b87af00d3a8571eb525a4319ec27"
    private let baseURL = "https://api.themoviedb.org/3/"
    
    func fetchMovies() async throws -> [Movie] {
        let urlString = "\(baseURL)movie/popular?api_key=\(apiKey)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw URLError(.badURL)
        }
        
        do {
            // Fetch data from the URL
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the data into the desired type
            let response = try JSONDecoder().decode(MovieResponse.self, from: data)
            print("Response:", response)
            return response.results
            
        } catch let urlError as URLError {
            print("URL Error: \(urlError.localizedDescription)")
            throw urlError
        } catch let decodingError as DecodingError {
            print("Decoding Error: \(decodingError.localizedDescription)")
            throw decodingError
        } catch {
            print("Unexpected Error: \(error.localizedDescription)")
            throw error
        }
    }

}

struct MovieResponse: Decodable {
    let results: [Movie]
}
