//
//  MovieJsonResponse.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import SwiftyJSON
struct MovieResults {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieResults {
    private enum ResponseCodingKeys: String {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from json: JSON) {
        page = json[ResponseCodingKeys.page.rawValue].intValue
        numberOfResults = json[ResponseCodingKeys.numberOfResults.rawValue].intValue
        numberOfPages = json[ResponseCodingKeys.numberOfPages.rawValue].intValue
        movies = json[ResponseCodingKeys.movies.rawValue].arrayValue.map{Movie(from: $0)}
    }
}
