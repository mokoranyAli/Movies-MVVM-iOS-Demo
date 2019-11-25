//
//  MovieAPI.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation


import Moya

enum MovieApi {
    case recommend(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}


enum NetworkEnvironment {
    case qa
    case production
    case staging
}


extension MovieApi {
    
    var sampleData: Data {
        
        //return Data()
        switch self {
        case .recommend : return stubbedResponse("Recommended")
        case .popular  : return stubbedResponse("Popular")
        case .newMovies : return stubbedResponse("NewMovies")
        case .video  : return stubbedResponse("Video")

        }
    }
    
    func stubbedResponse(_ filename:String)-> Data! {
        
        @objc class TestClass: NSObject { }
           
           let bundle = Bundle(for: TestClass.self)
           let path = bundle.path(forResource: filename, ofType: "json")
           return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}


extension MovieApi: TargetType {
    
    
    
    private var environmentBaseURL: String {
        switch NetworkManger.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://api.themoviedb.org/3/movie/"
        case .staging: return "https://api.themoviedb.org/3/movie/"
        }
    }
    
    /// The target's base `URL`.
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("BaseURL could not be configured")
        }
        return url
    }

    
    
    
    
    var headers: [String : String]? {
             return ["Content-type": "application/json"]
    }
    
    
    
    var path: String {
        switch self {
        case .recommend(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recommend, .popular, .newMovies, .video:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .recommend, .video:
            return ["api_key": Constants.API_Key]
        case .popular(let page), .newMovies(let page):
            return ["page": page, "api_key": Constants.API_Key]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .recommend, .popular, .newMovies, .video:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        
       // return .requestPlain
        switch self {
        case .recommend, .video:
            return .requestParameters(parameters: ["api_key":  Constants.API_Key], encoding: URLEncoding.queryString)
        case .popular(let page), .newMovies(let page):
            return .requestParameters(parameters: ["page":page, "api_key": Constants.API_Key], encoding: URLEncoding.queryString)
       }
    }
}
