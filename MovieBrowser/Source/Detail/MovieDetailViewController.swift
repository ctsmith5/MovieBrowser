//
//  MovieDetailViewController.swift
//  MovieBrowser
//
//  Created by Colin Smith on 5/3/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    var genreNames: [String] = []
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleLabel.text = movie?.title
        if let rating = movie?.ratingScore {
            ratingLabel.text = "Rating: \(rating)"
        }
        releaseDateLabel.text = movie?.releaseDate?.formatDateString()
        descriptionLabel.text = movie?.description
        
        configureImage()
        configureGenres()
    }
    
    func configureGenres() {
        guard let genreCodes = movie?.genreIDs else { return }
        for genreCode in genreCodes {
            let matchingGenre = MovieController.shared.genres.first { (genre) -> Bool in
                return genre.id == genreCode
            }
            if let name = matchingGenre?.name {
                genreNames.append(name + " ")
            }
        }
        genreLabel.text = genreNames.joined()
    }
    
    
    func configureImage() {
        guard let image = movie?.imagePath else { return }
        MovieController.shared.getImageFor(path: image) { (imageData) in
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    
    
}
