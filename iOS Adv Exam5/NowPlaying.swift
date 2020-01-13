//
//  NowPlaying.swift
//  TmdbDemo
//
//  Created by SHIH-YING PAN on 2019/10/6.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var title: String?
    var voteAverage: Float?
    var overview: String?
    var id: Int?
    var posterPath: String?
    
    var posterUrl: URL? {
        if let imageConfiguration = MovieService.shared.imageConfiguration, let secureBaseUrl = imageConfiguration.secureBaseUrl, let posterSizes = imageConfiguration.posterSizes, let posterPath = posterPath {
            if posterSizes.count >= 5 {
                return URL(string: "\(secureBaseUrl)\(posterSizes[4])\(posterPath)")

            } else {
                
                return URL(string: "\(secureBaseUrl)\(posterSizes[0])\(posterPath)")
            }
        } else {
            return nil
        }
        
    }
    
}

struct NowPlaying: Codable {
    var page: Int?
    var totalPages: Int?
    var results: [Movie]?
}

struct TV: Codable {
    var title: String?
    var voteAverage: Float?
    var overview: String?
    var id: Int?
    var posterPath: String?
    
    var posterUrl: URL? {
        if let imageConfiguration = TVService.shared.imageConfiguration, let secureBaseUrl = imageConfiguration.secureBaseUrl, let posterSizes = imageConfiguration.posterSizes, let posterPath = posterPath {
            if posterSizes.count >= 5 {
                return URL(string: "\(secureBaseUrl)\(posterSizes[4])\(posterPath)")

            } else {
                
                return URL(string: "\(secureBaseUrl)\(posterSizes[0])\(posterPath)")
            }
        } else {
            return nil
        }
        
    }
    
}

struct TVNowPlaying: Codable {
    var page: Int?
    var totalPages: Int?
    var results: [TV]?
}
