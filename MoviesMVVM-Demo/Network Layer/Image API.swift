//
//  Image API.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/25/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation

enum LogoSize: String {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

enum PosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

enum ProfileSize: String {
    case w45
    case w185
    case h632
    case original
}

enum ImageAPI {
    case logo(path: String, size: LogoSize)
    case poster(path: String, size: PosterSize)
    case profile(path: String, size: ProfileSize)
}

