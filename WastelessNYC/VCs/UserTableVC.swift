//
//  UserTableVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class UserTableVC: UIViewController {
    var user: AppUser!
    var isCurrentUser = false
    
    @IBAction func postController(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "CreatePost") as! CreateFoodVC
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    var posts = [Post]() {
        didSet {
            
                tableView.reloadData()
            
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      user = AppUser(from: FirebaseAuthService.manager.currentUser!)
        getPostsForThisUser()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.UserCell.rawValue, for: indexPath) as! UserCell
        var currentPost = posts[indexPath.row]
        cell.foodName.text = currentPost.title
        let url = URL(string: currentPost.imageURL)
        cell.foodImage.kf.setImage(with: url)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  101
    }
    
    
}
