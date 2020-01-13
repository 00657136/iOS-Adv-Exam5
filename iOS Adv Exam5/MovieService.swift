//
//  MovieService.swift
//  TmdbDemo
//
//  Created by SHIH-YING PAN on 2019/10/6.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation
import UIKit

class MovieService {
    
    static let shared = MovieService()
    var imageConfiguration: ImageConfiguration?
    let version = 3
    let baseUrlString = "https://api.themoviedb.org"
    let apiKey = "b17c1f1148864e6cc74057601a2df8e5"
       
    func getImage(url: URL?, completionHandler: @escaping (UIImage?) -> ()) {
           if let url = url {
               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let data = data, let image = UIImage(data: data) {
                       completionHandler(image)
                   } else {
                       completionHandler(nil)
                   }
               }
               task.resume()
           }
       }
    
    func getConfiguration() {
           var urlComponents = URLComponents(string: baseUrlString)
           urlComponents?.path = "/\(version)/configuration"
           urlComponents?.query = "api_key=\(apiKey)"
           if let url = urlComponents?.url {
               let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                   let decoder = JSONDecoder()
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                   if let data = data, let movieConfiguration = try? decoder.decode(MovieConfiguration.self, from: data) {
                       self.imageConfiguration = movieConfiguration.images
                   }
               }
               task.resume()
           }
           
           
       }
    
    func getNowPlaying(page: Int, completion: @escaping (NowPlaying?) -> () ) {
        var urlComponents = URLComponents(string: baseUrlString)
        urlComponents?.path = "/\(version)/movie/now_playing"
        urlComponents?.query = "api_key=\(apiKey)&page=\(page)&language=zh-TW"
        if let url = urlComponents?.url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = data, let nowPlaying = try? decoder.decode(NowPlaying.self, from: data) {
                    
                    completion(nowPlaying)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
        
    }
    
      
    
    
}


