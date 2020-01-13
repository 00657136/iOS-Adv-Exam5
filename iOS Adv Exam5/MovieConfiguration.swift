//
//  MovieConfiguration.swift
//  TmdbDemo
//
//  Created by SHIH-YING PAN on 2019/10/6.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct ImageConfiguration: Codable {
    var secureBaseUrl: String?
    var posterSizes: [String]?
    
}

struct MovieConfiguration: Codable {
    var images: ImageConfiguration?
}
