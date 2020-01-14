//
//  detailViewController.swift
//  iOS Adv Exam5
//
//  Created by User09 on 2020/1/13.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var VoteAverage: UILabel!
    var movies = [Movie]()
     var detailText = ""
    var posterImage : UIImage?
    var voteAverage : Float = 0
    var movietitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        moviePoster.image = posterImage
        movieDetail.numberOfLines = 15
        movieDetail.text = detailText
        movieTitle.text = movietitle
        VoteAverage.text = "評價為：\(voteAverage)分"
        // Do any additional setup after loading the view.
    }
    
//
//    @IBSegueAction func sendDetail(_ coder: NSCoder) -> detailViewController? {
//
//
//        return detailViewController(coder: coder)
//    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
