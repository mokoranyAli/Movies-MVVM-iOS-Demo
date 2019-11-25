//
//  ViewController.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.movieCellViewModel = cellVM
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
    }
    
    
    lazy var viewModel: MovieViewModel = {
        return MovieViewModel()
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
        
            
    }
        
        
        
        

    func initView() {
    
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    
                        self.tableView.alpha = 0.0
                    print("error empty")

                case .loading:
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                        print("loading")
                    })
                case .populated:
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                        print("populated")
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.initFetch()

    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}


