//
//  SignInVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var passwordTextFiekld: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func loginUser(_ sender: UIButton) {
      tryLogin()
    }
    
  //MARK: Functions
  



      func tryLogin() {
          guard let email = emailTextField.text, let password = passwordTextFiekld.text else {
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
          FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
              self.handleLoginResponse(with: result)
          }
      }

  //MARK: Private methods

      private func showAlert(with title: String, and message: String) {
          let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
          present(alertVC, animated: true, completion: nil)
      }

      private func handleLoginResponse(with result: Result<(), Error>) {
          switch result {
          case .failure(let error):
              showAlert(with: "Error", and: "Could not log in. Error: \(error)")
          case .success:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let loginViewController = storyboard.instantiateViewController(withIdentifier: "AllFoodVC") as! AllFoodVC
//              let nextVC = UserTableVC()
//              nextVC.modalPresentationStyle = .fullScreen
//              present(nextVC, animated: true, completion: nil)

          }
      }
}
