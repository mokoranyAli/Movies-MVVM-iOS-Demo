//
//  ViewController.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/24/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    
    lazy var viewModel: MovieViewModel = {
        return MovieViewModel()
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
        
            
    }
             

    func initView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if Connectivity.isConnectedToInternet() {
//            
//            showAlert("Check Your Internet....")
//        }
//    }
    
    


}


