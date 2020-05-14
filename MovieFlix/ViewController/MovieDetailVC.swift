//
//  MovieDetailVC.swift
//  MovieFlix
//
//  Created by Tushar Premal on 14/05/20.
//  Copyright © 2020 Tushar Premal. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

    var movieModel:MovieViewModel!
    @IBOutlet weak var imgPoster:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblOverview:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var lblPopularity:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        self.lblTitle.text = movieModel.title
        self.lblOverview.text = movieModel.overview
        self.lblDate.text = movieModel.date
        self.lblPopularity.text = movieModel.popularity
        movieModel.setImage(self.imgPoster)
    }
    
}
