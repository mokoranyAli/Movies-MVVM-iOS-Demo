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
    
    var movieCellViewModel : MovieCellViewModel? {
           didSet {

            
            print(movieCellViewModel?.movieName)
            nameLabel.text = movieCellViewModel?.movieName
            rateLabel.text = movieCellViewModel?.MovieRate
            yearLabel.text = movieCellViewModel?.MovieYear
            movieImageView.sd_setImage(with: URL.getTMDBImage(type: .poster(path: movieCellViewModel!.MovieImageUrl , size: .original)) , completed: nil)
            
           }
    
    

    
}
}
