//
//  UserTableVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import Firebase
class UserTableVC: UIViewController {
    var user: AppUser!
    var isCurrentUser = false
    
    var posts = [Post]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    private func getPostsForThisUser() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            FirestoreService.manager.getPosts(forUserID: self?.user.uid ?? "") { (result) in
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    print(":( \(error)")
                }
            }
        }
    }

}
extension UserTableVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.UserCell.rawValue, for: indexPath) as! FoodCell
        var currentPost = posts[indexPath.row]
        cell.foodName.text = currentPost.title
        return cell
    }
    
    
}
