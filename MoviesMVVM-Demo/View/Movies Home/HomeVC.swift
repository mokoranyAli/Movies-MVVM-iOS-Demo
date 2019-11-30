//
//  ViewController.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa
import Foundation


class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    public var movies = PublishSubject<[Movie]>()
     let disposeBag = DisposeBag()
    
//    lazy var viewModel: MovieViewModel = {
//        return MovieViewModel()
//    }()
    
    //DI from sence delegate
     var viewModel:MovieViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sss")
        tableView.rowHeight = 200
        //tableView.rowHeight = UITableView.automaticDimension
        setupBindings()
        setupBinding()
        viewModel.initFetch()
        
        
            
    }
    fileprivate func setupBindings() {
               
        print("s")
               // binding loading to vc
               
       //        homeViewModel.loading
       //            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
               viewModel.loading.observeOn(MainScheduler.instance).subscribe(onNext: { (state) in
               
                   switch state {
                       
                   case false :
                       SVProgressHUD.dismiss()
                       print("faaaalse")
                   case true:
                       print("true")
                   }
                   }).disposed(by: disposeBag)
               
               // observing errors to show
               
               viewModel
                   .error
                   .observeOn(MainScheduler.instance)
                   .subscribe(onNext: { (error) in
                       switch error {
                       case .internetError(let message):
                           self.showAlert(message)
                       case .serverMessage(let message):
                           self.showAlert(message)
                       }
                   })
                   .disposed(by: disposeBag)
               
               
               
               
              
               
               // binding tracks to track container
               
               viewModel
                   .movies
                   .observeOn(MainScheduler.instance)
                   .bind(to: self.movies)
                   .disposed(by: disposeBag)
        
        print("\(self.movies)sdfsdflkjsdfnkdasnf;qodwagnfqower;lgwe;lrgmewr;")
              
        
           }
             


    private func setupBinding(){
        
       
        
        movies.bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: MovieCell.self)) {  (row,movie,cell) in
            cell.cellMovie = movie
            
            print(cell.cellMovie.title)
            }.disposed(by: disposeBag)
    
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }
    
    
    func showAlert( _ message: String ) {
          let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
          alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }


}


