//
//  WSManager.swift
//  MovieFlix
//
//  Created by Tushar Premal on 14/05/20.
//  Copyright © 2020 Tushar Premal. All rights reserved.
//

import Foundation

class WSManager {
    
    static let shared = WSManager()
    
    func getMovieList(_ index: Int,_ postCompleted : @escaping (_ succeeded: Bool, _ responsedata: [MovieViewModel]) -> ()){
        var strURL = AppConstant.kNowPlayingURL
        if index == 1{
            strURL = AppConstant.kTopRatedURL
        }
        var request = URLRequest(url:URL(string:strURL)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if (error != nil){
                    print(error!.localizedDescription)
                    postCompleted(false,[MovieViewModel]())
                }else{
                    var error: NSError?
                    var response:Response?
                    do {
                        response = try JSONDecoder().decode(Response.self, from: data!)
                    }catch let error1 as NSError {
                        error = error1
                        response = nil
                    } catch {
                        fatalError()
                    }
                    if (error != nil){
                        print(error!.localizedDescription)
                        postCompleted(false, [MovieViewModel]())
                    }else{
                        var arrModel = [MovieViewModel]()
                        for result in response!.results{
                            arrModel.append(MovieViewModel.init(result))
                        }
                        postCompleted(true,arrModel)
                    }
                }
            }
        }
        task.resume()
    }
}
