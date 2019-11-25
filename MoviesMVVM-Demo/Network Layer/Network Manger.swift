//
//  Network Manger.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

//protocol Networkable {
//
//    //var provider: MoyaProvider<MovieApi> { get }
//
//    func getNewMovies(page: Int, sortType: PopularMoviesSortType, completion: @escaping ([Movie]?, Swift.Error?) -> ())
//}

class NetworkManger{
public static let shared = NetworkManger()
 static let environment: NetworkEnvironment = .staging
private init() {}

private let provider = MoyaProvider<MovieApi>()
    
    
    
    func getNewMovies(page: Int, sortType: PopularMoviesSortType, completion: @escaping ([Movie]?, Swift.Error?) -> ()) {
           provider.request(.popular(page: page)) { (result) in
               switch result {
               case let .success(response):
                   let json = try!  JSON(data: response.data)
                  // print(json)
                   completion(MovieResults(from: json).movies, nil)
               case let .failure(error):
                   print(error)
                   completion(nil, error)
               }
           }
       }
        
        
        
        
        
        
    }

