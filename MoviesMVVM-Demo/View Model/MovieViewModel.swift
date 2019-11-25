//
//  MovieViewModel.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/25/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    var API_Service : Networkable!
    
    init(ApiService:Networkable) {
        self.API_Service = ApiService
    }
    
    
    private var movies:[Movie]=[Movie]()
    
    private var cellViewModels: [MovieCellViewModel] = [MovieCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isAllowSegue: Bool = false
    var selectedMovie: Movie?
    
    func initFetch() {
        state = .loading
        
        
        API_Service.getNewMovies(page: 1, sortType: .popularity) { [weak self] (movies, error) in
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.state = .error
                self.alertMessage  = error.debugDescription
                print(error.debugDescription)
                return
            }
            print(movies?.count)
            self.processFetchedPhoto(movies: movies!)
            self.state = .populated
            
        }
        
        
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> MovieCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( movie: Movie ) -> MovieCellViewModel {
        
        //Wrap a description
        
        return MovieCellViewModel(movieName: movie.title, MovieRate: String(movie.rating), MovieImageUrl: movie.posterPath, MovieYear: movie.releaseDate)
        
    }
    
    private func processFetchedPhoto( movies: [Movie] ) {
        self.movies = movies // Cache
        var tempArray = [MovieCellViewModel]()
        for m in movies {
            tempArray.append( createCellViewModel(movie: m) )
        }
        self.cellViewModels = tempArray
    }
    
    
}


extension MovieViewModel {
    
    
    
    func didSelectedAt(indexPath:IndexPath){
        let movie = self.movies[indexPath.row]
       
            self.isAllowSegue = true
            self.selectedMovie = movie
        
        
    }
}

