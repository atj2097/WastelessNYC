//
//  AllFoodVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class AllFoodVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts = [Post]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getPosts()
        // Do any additional setup after loading the view.
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



}
extension AllFoodVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.FoodCell.rawValue, for: indexPath)
        let post = posts[indexPath.row]
//        cell.textLabel?.text = post.title
//        cell.detailTextLabel?.text = post.body
        return cell
    }

}

extension AllFoodVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let postDetailVC = PostDetailViewController()
        postDetailVC.post = post
self.navigationController?.pushViewController(postDetailVC, animated: true)
    }
}
