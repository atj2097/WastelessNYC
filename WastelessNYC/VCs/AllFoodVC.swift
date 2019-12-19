//
//  AllFoodVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import Kingfisher
class AllFoodVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [Post]() {
        didSet {
            self.tableView.reloadData()
        }
    }
  
  
  private var searchWord: String? {
      didSet {
         tableView.reloadData()
      }
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
    }
  
    private func getPosts() {
        FirestoreService.manager.getAllPosts { (result) in
            switch result {
            case .success(let posts):
                self.posts = posts
            case .failure(let error):
                print("error getting posts \(error)")
            }
        }
    }
    
    private func getPostsForLoc(searchString: String) {
        FirestoreService.manager.getPostsForLocation(forLocation: searchString, completion: {(result) in
            switch result {
                       case .success(let posts):
                           self.posts = posts
                       case .failure(let error):
                           print("error getting posts \(error)")
                       }
        })
    }



}
extension AllFoodVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.FoodCell.rawValue, for: indexPath) as? FoodCell else {return UITableViewCell()}
        let post = posts[indexPath.row]
          cell.foodName.text = post.title
          cell.dateExpiration.text = post.body
        let url = URL(string: post.imageURL)
      cell.foodImage.kf.setImage(with: url)
      
      return cell

    }
}

extension AllFoodVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let postDetailVC = storyboard.instantiateViewController(identifier: "PostDVC") as! PostDetailViewController
        postDetailVC.post = post
self.navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  101
    }
   
}


extension AllFoodVC: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchWord = searchBar.text?.lowercased()
    getPosts()
  }
    func searchBar(_ searchBar: UISearchBar, textDidReturn searchText: String) {
        self.searchWord = searchText.lowercased()
        getPostsForLoc(searchString: searchWord ?? "Brooklyn")
    }
  
}
