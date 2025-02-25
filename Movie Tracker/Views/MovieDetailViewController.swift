

import UIKit

class MovieDetailViewController: UIViewController {

    private let movie: Movie
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let overviewLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        //configureView()
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.systemFont(ofSize: 16)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false

        favoriteButton.setTitle("Add to Favorites", for: .normal)
        favoriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(overviewLabel)
        view.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            overviewLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favoriteButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureView() {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        loadImage(urlString: "https://image.tmdb.org/t/p/w300\(movie.posterPath ?? "")")
    }
   
    private func loadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }

        @objc private func addToFavorites() {
            print("Added \(movie.title) to favorites")
        }
}
