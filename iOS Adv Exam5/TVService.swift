//
//  TVService.swift
//  iOS Adv Exam5
//
//  Created by User09 on 2020/1/13.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import Foundation
import UIKit

class TVService {
    
    static let shared = TVService()
    var imageConfiguration: ImageConfiguration?
    let version = 3
    let baseUrlString = "https://api.themoviedb.org"
    let apiKey = "1560a891d4fe5b3f8d4c890130336b52"
       
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
    
    func getNowPlaying(page: Int, completion: @escaping (TVNowPlaying?) -> () ) {
        var urlComponents = URLComponents(string: baseUrlString)
        urlComponents?.path = "/\(version)/tv/top_rated"
        urlComponents?.query = "api_key=\(apiKey)&page=\(page)&language=zh-TW"
        if let url = urlComponents?.url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = data, let nowPlaying = try? decoder.decode(TVNowPlaying.self, from: data) {
                    
                    completion(nowPlaying)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
        
    }
    
      
    
    
}
