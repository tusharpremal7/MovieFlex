//
//  MovieViewModel.swift
//  MovieFlix
//
//  Created by Tushar Premal on 14/05/20.
//  Copyright © 2020 Tushar Premal. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MovieViewModel{
    
    private let movieModel:MovieModel!
    
    init(_ model: MovieModel){
        self.movieModel = model
    }
    
    public var title: String {
        return movieModel.title ?? ""
    }
    
    public var overview: String {
        return movieModel.overview ?? ""
    }
    
    public var date: String {
        return movieModel.release_date ?? ""
    }
    
    public var popularity: String {
        return String.init(format: "%.1f%", movieModel.popularity ?? 0)
    }
    
    public var posterURL: URL? {
        if movieModel.poster_path ?? "" != ""{
            return URL.init(string: AppConstant.kImageBaseURL + "w500" + (movieModel.poster_path ?? ""))
        }
        return nil
    }
    
    func setCellDate(_ cell:MovieCollectionCell){
        cell.lblTitle.text = self.title
        cell.lblOverview.text = self.overview
        setImage(cell.imgPoster)
    }
    
    func isSearchContain(_ term:String)->Bool{
        if (self.title).lowercased().contains(term.lowercased()){
            return true
        }
        return false
    }
    
    func setImage(_ imgView:UIImageView){
        imgView.image = UIImage.init(named: "placeholder")
        if self.posterURL != nil{
            imgView.af.setImage(withURL: self.posterURL!, cacheKey: nil, placeholderImage: UIImage.init(named: "placeholder"), serializer: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true, completion: nil)
        }
    }
}
