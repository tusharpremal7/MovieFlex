//
//  Constant.swift
//  MovieFlix
//
//  Created by Tushar Premal on 14/05/20.
//  Copyright © 2020 Tushar Premal. All rights reserved.
//

import Foundation

struct AppConstant {
    static let kAPIKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let kImageBaseURL = "https://image.tmdb.org/t/p/"
    static let kNowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(kAPIKey)"
    static let kTopRatedURL = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(kAPIKey)"
}
