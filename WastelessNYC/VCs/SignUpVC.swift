//
//  SignUpVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignUpVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var createUser: UIButton!
    
    @IBAction func createUser(_ sender: UIButton) {
      trySignUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
  
  //MARK: Functions
  
    func trySignUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(with: "Error", and: "Please fill out all fields.")
            return
        }
        guard email.isValidEmail else {
            showAlert(with: "Error", and: "Please enter a valid email")
            return
        }
        guard password.isValidPassword else {
            showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }

        FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
            self?.handleCreateAccountResponse(with: result)
        }
    }
  
  
  private func showAlert(with title: String, and message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true, completion: nil)
  }
  
  private func handleCreateAccountResponse(with result: Result<User, Error>) {
      DispatchQueue.main.async { [weak self] in
          switch result {
          case .success(let user):
              FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                  self?.handleCreatedUserInFirestore(result: newResult)
              }
          case .failure(let error):
              self?.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
          }
      }
  }
  
  private func handleCreatedUserInFirestore(result: Result<(), Error>) {
      switch result {
      case .success:
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "AllFoodVC") as! AllFoodVC
//          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
//              else {
//                  return
//          }
//
//          UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
//                  window.rootViewController = UserTableVC()
//          }, completion: nil)
      case .failure(let error):
          self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
      }
  }
  
  
  
  
  

}
