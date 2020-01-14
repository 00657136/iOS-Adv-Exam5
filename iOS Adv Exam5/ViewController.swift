//
//  ViewController.swift
//  iOS Adv Exam5
//
//  Created by SHIH-YING PAN on 2019/11/3.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
//                             self.collectionView.reloadData()
//                             if self.collectionView.refreshControl?.isRefreshing == true {
//                                 self.collectionView.refreshControl?.endRefreshing()
//                             }
                         }
                     } else if fetchPage == self.currentPage! + 1 {
                         self.currentPage = fetchPage
                         var indexPaths = [IndexPath]()
                         for i in self.movies.count..<self.movies.count + results.count {
                             indexPaths.append(IndexPath(item: i, section: 0))
                         }
                         self.movies.append(contentsOf: results)
                         DispatchQueue.main.async {
                             //self.collectionView.insertItems(at: indexPaths)
                         }
                     }
                 }
             }
         }
         
     }
     
    @objc func refreshMovie() {
        getMovies(isRefresh: true)
    }
     

     

    var tempMovies = ["ipad", "ipad", "iPad", "iMac", "AirPods", "Apple Watch", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac", "iMac"]
    let cellId = "cellId"
    //var tempArray = ["iPhone", "Macbook", "iPad", "iMac", "AirPods", "Apple Watch"]
    var filteredArray = [String]()
    var isSearching = false
    
    lazy var mainTable: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return table
    }()
    
    let mainSearchBar = MainSearchBar()
    
    fileprivate func setupView(){
        view.addSubview(mainSearchBar)
        view.addSubview(mainTable)
        
        mainSearchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mainSearchBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mainSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
        mainTable.topAnchor.constraint(equalTo: mainSearchBar.bottomAnchor, constant: 10).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieService.shared.getConfiguration()
        
        getMovies(isRefresh: true)
        
//        for i in 0...2{
//            tempArray[i] = "2"//movies[i].title!
//            //print(movies[0].title)
//        }
        
        setupView()
        mainTable.delegate = self
        mainTable.dataSource = self
        mainSearchBar.delegate = self
        mainSearchBar.returnKeyType = UIReturnKeyType.done
        print(movies.count)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
    }



}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredArray.count
        }else{
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var device: String?
        let movie = movies[indexPath.row]
        if isSearching {
            device = filteredArray[indexPath.row]
        }else{
            //device = tempArray[indexPath.row]
            tempMovies[indexPath.row] = movies[indexPath.row].title!
            device = movie.title
            print(indexPath.row)
        }
        let cell = mainTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.textLabel?.text = device
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if mainSearchBar.text == nil || mainSearchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            mainTable.reloadData()
        }else{
            isSearching = true
            //filteredArray = tempArray.filter({$0.range(of: mainSearchBar.text!, options: .caseInsensitive) != nil })
            filteredArray = tempMovies.filter({$0.range(of: mainSearchBar.text!, options: .caseInsensitive) != nil })
            mainTable.reloadData()
        }
    }

}
