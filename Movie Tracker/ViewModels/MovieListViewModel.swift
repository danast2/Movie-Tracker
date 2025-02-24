import Foundation

class MovieListViewModel {
    private let movieService = MovieService()
    var movies: [Movie] = []
    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchMovies() {
        movieService.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                    self?.onMoviesUpdated?()
                case .failure(let error):
                    self?.onError?("Failed to load movies: \(error)")
                }
            }
        }
    }
}
