protocol MovieAPIService{
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

import Foundation

class MovieAPIServiceClass: MovieAPIService {
    func searchMovies(query: String, completion: @escaping (Result<[Movie], any Error>) -> Void) {
        <#code#>
    }
    
    
    private let baseURL = "https://api.themoviedb.org/3/search/movie"
    
    private let apiKey = "APIKEY"
    
    private func makeHTTPRequest (url: String, completion: @escaping (Result<[Movie], any Error>) -> Void) {}
    private func convertJSONToMovie (_ data: Data) -> [Movie]? {}
}
