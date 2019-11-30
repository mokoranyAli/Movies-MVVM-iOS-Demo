//
//  MovieCell.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    	
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    public var cellMovie : Movie! {
        didSet {
            self.movieImageView.clipsToBounds = true
            self.movieImageView.layer.cornerRadius = 3
            let url = URL.getTMDBImage(type: .poster(path: cellMovie.posterPath , size: .original))
            self.movieImageView.loadImage(fromURL: url)
            self.nameLabel.text = cellMovie.title
            self.rateLabel.text = String(cellMovie.rating)
            self.yearLabel.text = cellMovie.releaseDate
        }
    }
    
//    var movieCellViewModel : MovieCellViewModel? {
//           didSet {
//
//
//           // print(movieCellViewModel?.movieName)
//
//            movieImageView.sd_setImage(with: URL.getTMDBImage(type: .poster(path: movieCellViewModel!.MovieImageUrl , size: .original)) , completed: nil)
//
//           }
    
    

    
}

