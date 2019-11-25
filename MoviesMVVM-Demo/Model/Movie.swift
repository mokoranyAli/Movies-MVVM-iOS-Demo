//
//  Movie.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Movie {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
}

extension Movie {
    
    enum MovieCodingKeys: String {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
    
    init(from json: JSON) {
        id = json[MovieCodingKeys.id.rawValue].intValue
        posterPath = json[MovieCodingKeys.posterPath.rawValue].stringValue
        backdrop = json[MovieCodingKeys.backdrop.rawValue].stringValue
        title = json[MovieCodingKeys.title.rawValue].stringValue
        releaseDate = json[MovieCodingKeys.releaseDate.rawValue].stringValue
        rating = json[MovieCodingKeys.rating.rawValue].doubleValue
        overview = json[MovieCodingKeys.overview.rawValue].stringValue
    }
}
