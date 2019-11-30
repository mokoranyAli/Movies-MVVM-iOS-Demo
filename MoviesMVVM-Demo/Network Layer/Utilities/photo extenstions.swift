//
//  photo extenstions.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/30/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import UIKit

public extension UIImageView {
func loadImage(fromURL url: String) {
       guard let imageURL = URL(string: url) else {
           return
       }
       
       let cache =  URLCache.shared
       let request = URLRequest(url: imageURL)
       DispatchQueue.global(qos: .userInitiated).async {
           if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
               DispatchQueue.main.async {
                   self.transition(toImage: image)
               }
           } else {
               URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                   if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                       let cachedData = CachedURLResponse(response: response, data: data)
                       cache.storeCachedResponse(cachedData, for: request)
                       DispatchQueue.main.async {
                           self.transition(toImage: image)
                       }
                   }
               }).resume()
           }
       }
   }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
}

public extension URL {
    
   internal static func getTMDBImage(type: ImageAPI) -> String {
        
        let baseURL: String = "https://image.tmdb.org/t/p/"
        
        var url: String!
        
        switch type {
        case .logo(let path, let size):
            url = baseURL + size.rawValue + path
        case .poster(let path, let size):
            url = baseURL + size.rawValue + path
        case .profile(let path, let size):
            url = baseURL + size.rawValue + path
        }
        
        guard let finalURL = url else {
            fatalError("Unable to create image url")
        }
        
        return finalURL
    }
    
}

