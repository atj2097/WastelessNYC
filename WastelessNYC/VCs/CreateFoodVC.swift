//
//  CreateFoodVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class CreateFoodVC: UIViewController {
    var currentUser: AppUser!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var foodTextInput: UITextField!
    @IBOutlet weak var addressInputField: UIImageView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var createPost: UIButton!
    
    @IBAction func create(_ sender: UIButton) {
//        guard let date = titleTextField.text, title != "", let body = bodyTextView.text, body != "" else {
//            showAlert(with: "Error", and: "All fields must be filled")
//            return
//        }
        
        guard let user = FirebaseAuthService.manager.currentUser else {
            showAlert(with: "Error", and: "You must be logged in to create a post")
            return
        }
        let newPost = Post(title: foodTextInput.text!, body: address.text!, creatorID: currentUser.uid, dateCreated: datePicker.date)
        FirestoreService.manager.createPost(post: newPost) { (result) in
        self.handlePostResponse(withResult: result)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   private func handlePostResponse(withResult result: Result<Void, Error>) {
        switch result {
        case .success:
            let alertVC = UIAlertController(title: "Yay", message: "New post was added", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (action)  in
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }))
            
            present(alertVC, animated: true, completion: nil)
        case let .failure(error):
            print("An error occurred creating the post: \(error)")
        }
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

}
