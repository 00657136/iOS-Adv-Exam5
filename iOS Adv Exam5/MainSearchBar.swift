//
//  MainSearchBar.swift
//  iOS Adv Exam5
//
//  Created by User09 on 2020/1/14.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import UIKit

class MainSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
