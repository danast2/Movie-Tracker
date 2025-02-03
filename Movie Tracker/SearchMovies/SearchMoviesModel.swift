
import Foundation

protocol SearchMoviesModel {
    /// Метод для поиска фильмов по названию
    /// - Parameters:
    ///   - query: Текстовый запрос (название фильма)
    ///   - completion: Замыкание с результатом — массив фильмов или ошибка
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}


class SearchMoviesModelClass: SearchMoviesModel {
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        <#code#>
    }
}
