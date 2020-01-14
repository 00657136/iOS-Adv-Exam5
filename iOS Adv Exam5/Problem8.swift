//
//  MovieCollectionViewController.swift
//  TmdbDemo
//
//  Created by SHIH-YING PAN on 2019/10/6.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

// 加入 UIRefreshControl，下拉更新時抓取第一頁的電影資料顯示
class Problem8: UICollectionViewController {
    //var TVs = [TV]()
    var movies = [Movie]()
    var currentPage: Int?
    var totalPages: Int?
    
    func getMovies(isRefresh: Bool) {
        
        var fetchPage = 1 + (currentPage ?? 0)
        if isRefresh {
            fetchPage = 1
        }
        if fetchPage == 1 || fetchPage <= totalPages! {
            
            MovieService.shared.getNowPlaying(page: fetchPage) { (nowPlaying) in
                if let nowPlaying = nowPlaying, let results = nowPlaying.results {
                    self.totalPages = nowPlaying.totalPages
                    if fetchPage == 1 {
                        self.currentPage = 1
                        self.movies = results
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            if self.collectionView.refreshControl?.isRefreshing == true {
                                self.collectionView.refreshControl?.endRefreshing()
                            }
                        }
                    } else if fetchPage == self.currentPage! + 1 {
                        self.currentPage = fetchPage
                        var indexPaths = [IndexPath]()
                        for i in self.movies.count..<self.movies.count + results.count {
                            indexPaths.append(IndexPath(item: i, section: 0))
                        }
                        self.movies.append(contentsOf: results)
                        DispatchQueue.main.async {
                            self.collectionView.insertItems(at: indexPaths)
                        }
                    }
                }
            }
        }
        
    }
    
   @objc func refreshMovie() {
       getMovies(isRefresh: true)
   }
    
//    func getTVs(isRefresh: Bool) {
//
//         var fetchPage = 1 + (currentPage ?? 0)
//         if isRefresh {
//             fetchPage = 1
//         }
//         if fetchPage == 1 || fetchPage <= totalPages! {
//
//             TVService.shared.getNowPlaying(page: fetchPage) { (nowPlaying) in
//                 if let nowPlaying = nowPlaying, let results = nowPlaying.results {
//                     self.totalPages = nowPlaying.totalPages
//                     if fetchPage == 1 {
//                         self.currentPage = 1
//                         self.TVs = results
//                         DispatchQueue.main.async {
//                             self.collectionView.reloadData()
//                             if self.collectionView.refreshControl?.isRefreshing == true {
//                                 self.collectionView.refreshControl?.endRefreshing()
//                             }
//                         }
//                     } else if fetchPage == self.currentPage! + 1 {
//                         self.currentPage = fetchPage
//                         var indexPaths = [IndexPath]()
//                         for i in self.TVs.count..<self.TVs.count + results.count {
//                             indexPaths.append(IndexPath(item: i, section: 0))
//                         }
//                         self.TVs.append(contentsOf: results)
//                         DispatchQueue.main.async {
//                             self.collectionView.insertItems(at: indexPaths)
//                         }
//                     }
//                 }
//             }
//         }
//
//     }
//
//    @objc func refreshTV() {
//        getTVs(isRefresh: true)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        collectionView.collectionViewLayout =  UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            let groupHeight: NSCollectionLayoutDimension
            if sectionIndex == 0 {
                groupHeight = .absolute(200)
            } else {
                groupHeight = .absolute(200)
            }

         

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: groupHeight)


            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            if sectionIndex == 0 {
                section.orthogonalScrollingBehavior = .groupPagingCentered
            }

            return section

        }
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = (collectionView.bounds.width - 10) / 2
        layout?.itemSize = CGSize(width: width, height: width)
        layout?.estimatedItemSize = .zero
        //TVService.shared.getConfiguration()
        MovieService.shared.getConfiguration()
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshMovie), for: .valueChanged)
        //collectionView.refreshControl?.addTarget(self, action: #selector(refreshTV), for: .valueChanged)
        collectionView.refreshControl?.beginRefreshing()
        getMovies(isRefresh: true)
        //getTVs(isRefresh: true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
            return movies.count
        } else {
        return movies.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

           if indexPath.item == movies.count - 1 {
               getMovies(isRefresh: false)
           }
        
//            if indexPath.item == TVs.count - 1 {
//                getTVs(isRefresh: false)
//            }
       }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.item]
        let vc = storyboard?.instantiateViewController(identifier: "detailViewController") as? detailViewController
        MovieService.shared.getImage(url: movie.posterUrl) { (image) in
            if let image = image {
                //DispatchQueue.main.async {
                    vc?.posterImage = image
                    //vc?.posterImage = image
                //}
            }
        }
        //vc?.posterImage = MovieService.shared.getImage(url: movie.posterUrl)
        vc?.detailText = movie.overview!
        vc?.movietitle = movie.title!
        vc?.voteAverage = movie.voteAverage!
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
//        let TV = TVs[indexPath.item]
//        cell.nameLabel.text = TV.title
//        cell.photoImageView.image = UIImage(systemName: "film")
//        TVService.shared.getImage(url: TV.posterUrl) { (image) in
//            if let image = image {
//                DispatchQueue.main.async {
//                    cell.photoImageView.image = image
//                }
//            }
//        }
        
        // Configure the cell
        let movie = movies[indexPath.item]
        cell.nameLabel.text = movie.title
        cell.photoImageView.image = UIImage(systemName: "film")
        MovieService.shared.getImage(url: movie.posterUrl) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        
        
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
