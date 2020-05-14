//
//  MovieModel.swift
//  MovieFlix
//
//  Created by Tushar Premal on 14/05/20.
//  Copyright © 2020 Tushar Premal. All rights reserved.
//

import Foundation
import UIKit


struct Response: Codable
{
    struct results: Codable {
        var title:String?
        var overview:String?
        var release_date:String?
        var poster_path:String?
        var popularity:Double?
    }
    
    var results:[results]
}

class MovieModel{

    var title:String?
    var overview:String?
    var release_date:String?
    var poster_path:String?
    var popularity:Double?
    
}
