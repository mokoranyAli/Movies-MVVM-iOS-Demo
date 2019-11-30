//
//  MovieViewModel.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/25/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import RxSwift
import Foundation

class MovieViewModel {
    
   
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
        
    }
    
       public let movies : PublishSubject<[Movie]> = PublishSubject()
       public let loading: PublishSubject<Bool> = PublishSubject()
       public let error : PublishSubject<HomeError> = PublishSubject()
       private let disposable = DisposeBag()

    
    var API_Service : Networkable!
    
    init(ApiService:Networkable) {
        self.API_Service = ApiService
    }
    
    
    func initFetch() {
        
        
        
        API_Service.getNewMovies(page: 1, sortType: .popularity) { [weak self] (movies, error) in
            
            
            
            guard let self = self else {
                return
            }
            
            self.loading.onNext(false)
            
            guard error == nil else {

                self.error.onNext(.internetError("Check your Internet connection."))
                return
            }
            print(movies?.count)
            self.movies.onNext(movies!)
            
            
        }
        
        
    }
    
   
}


