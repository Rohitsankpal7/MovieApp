import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MovieListViewModel
    
    init() {
        let apiService = MovieAPIService()
        let repository = MovieRepositoryImpl(apiService: apiService)
        _viewModel = StateObject(wrappedValue: MovieListViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading movies...")
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Text("Error loading movies")
                            .font(.headline)
                        Text(error.localizedDescription)
                            .font(.subheadline)
                            .foregroundColor(.red)
                        Button("Retry") {
                            viewModel.loadMovies()
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    List(viewModel.movies) { movie in
                        MovieItemView(movie: movie)
                    }
                }
            }
            .navigationTitle("Popular Movies")
        }
        .onAppear {
            if viewModel.movies.isEmpty {
                viewModel.loadMovies()
            }
        }
    }
} 