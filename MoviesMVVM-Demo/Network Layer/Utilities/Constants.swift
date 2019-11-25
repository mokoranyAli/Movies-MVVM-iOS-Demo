//
//  Constants.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation


public enum PopularMoviesSortType : String{
    case popularity = "popularity.desc"
    case voteAverage = "vote_average.desc"
    case releaseDate = "release_date.desc"
}

class Constants {
    
    
    static let API_Key = "7a312711d0d45c9da658b9206f3851dd"
    private init(){}
}
