import Foundation
import CoreData

class MovieStorageService {
    static let shared = MovieStorageService()
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieTracker")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveMovie(_ movie: Movie) {
        let savedMovie = SavedMovie(context: context)
        savedMovie.id = Int64(movie.id)
        savedMovie.title = movie.title
        savedMovie.overview = movie.overview
        savedMovie.posterPath = movie.posterPath
        savedMovie.releaseDate = movie.releaseDate
        savedMovie.rating = movie.rating
        
        do {
            try context.save()
            print("Saved movie: \(movie.title)")
        } catch {
            print("Failed to save movie: \(error)")
        }
    }
    
    func fetchSavedMovies() -> [SavedMovie] {
           let fetchRequest: NSFetchRequest<SavedMovie> = SavedMovie.fetchRequest()
           
           do {
               return try context.fetch(fetchRequest)
           } catch {
               print("Failed to fetch saved movies: \(error)")
               return []
           }
       }
       
       func deleteMovie(_ movie: SavedMovie) {
           context.delete(movie)
           do {
               try context.save()
               print("Deleted movie: \(movie.title ?? "Unknown")")
           } catch {
               print("Failed to delete movie: \(error)")
           }
       }
}
