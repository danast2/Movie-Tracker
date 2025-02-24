
import Foundation

class MovieService {
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
    private let apiKey = "YOUR_API_KEY" // Укажи свой API-ключ
    
    enum MovieServiceError: Error {
        case invalidURL
        case requestFailed
        case decodingError
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], MovieServiceError>) -> Void) {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
