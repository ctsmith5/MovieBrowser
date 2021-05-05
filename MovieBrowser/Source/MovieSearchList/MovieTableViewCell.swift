//
//  MovieTableViewCell.swift
//  MovieBrowser
//
//  Created by Colin Smith on 5/3/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movie: Movie?
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        movieTitleLabel.text = movie?.title
        releaseDateLabel.text = movie?.releaseDate?.formatDateString()
        ratingScoreLabel.text = "\(movie?.ratingScore ?? 0.0)"
    }
    
}
