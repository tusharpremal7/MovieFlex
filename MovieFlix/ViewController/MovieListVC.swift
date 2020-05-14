//
//  ViewController.swift
//  MovieFlix
//
//  Created by Tushar Premal on 13/05/20.
//  Copyright © 2020 Tushar Premal. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {

    @IBOutlet weak var collectionMovie:UICollectionView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    var arrMovies = [MovieViewModel]()
    var arrSearchMovies = [MovieViewModel]()
    var isSearchEnabled = false
    var refreshControl:UIRefreshControl!
    var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        overrideUserInterfaceStyle = .light
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.getMovieList), for: .valueChanged)
        collectionMovie.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMovieList()
    }
    
    @objc func getMovieList(){
        activityIndicator.startAnimating()
        activityIndicator.superview!.isHidden = false
        WSManager.shared.getMovieList(self.tabBarController!.selectedIndex) { (status, arr) in
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.superview!.isHidden = true
            if status{
                self.arrMovies = arr
                self.collectionMovie.reloadData()
            }
        }
    }
}

extension MovieListVC:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchEnabled ? arrSearchMovies.count : arrMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        let model = isSearchEnabled ? arrSearchMovies[indexPath.row] : arrMovies[indexPath.row]
        model.setCellDate(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let vc = self.storyboard!.instantiateViewController(identifier: "MovieDetailVC") as! MovieDetailVC
        vc.movieModel = isSearchEnabled ? arrSearchMovies[indexPath.row] : arrMovies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListVC:UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isSearchEnabled = false
        self.collectionMovie.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != ""{
            isSearchEnabled = true
            arrSearchMovies = arrMovies.filter({ (model) -> Bool in
                return model.isSearchContain(searchBar.text!)
            })
        }else{
            isSearchEnabled = false
        }
        self.collectionMovie.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}

