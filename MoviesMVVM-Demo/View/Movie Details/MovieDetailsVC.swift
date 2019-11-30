//
//  MovieDetailsVC.swift
//  MoviesMVVM-Demo
//
//  Created by Mohamed Korany Ali on 11/25/19.
//  Copyright © 2019 Mohamed Korany Ali. All rights reserved.
//
import Foundation
import UIKit
import SDWebImage


class MovieDetailsVC: UIViewController {
    
    var movie:Movie!
    
    @IBOutlet weak var movieImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movie.title)
        print(movie.id)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
