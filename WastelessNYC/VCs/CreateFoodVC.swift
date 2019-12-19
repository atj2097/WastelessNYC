//
//  CreateFoodVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import FirebaseAuth

class CreateFoodVC: UIViewController {
    var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
        
    }()
    var currentUser: AppUser!
    var image = UIImage() {
        didSet {
            self.imageView.image = image
        }
    }
    var imageURL: URL? = nil
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var foodTextInput: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var createPost: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func openPhotoPicker(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }
    
    @IBOutlet weak var uploadPhoto: UIButton!
    @IBAction func create(_ sender: UIButton) {
        guard let title = foodTextInput.text, title != "", let addy = address.text, addy != "" else {
            showAlert(with: "Error", and: "All fields must be filled")
            return
        }
        guard let imageURLString = imageURL?.absoluteString else {
            return
        }
        
        guard let user = FirebaseAuthService.manager.currentUser else {
            showAlert(with: "Error", and: "You must be logged in to create a post")
            return
        }
        
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newPost = Post(title: title, body: addy, creatorID: currentUserID, image: imageURLString, dateCreated: datePicker.date)
        FirestoreService.manager.createPost(post: newPost) { (result) in
        self.handlePostResponse(withResult: result)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var allPostsVC = storyboard.instantiateViewController(identifier: "AllPosts") as! AllFoodVC
            allPostsVC.modalPresentationStyle = .fullScreen
            self.present(allPostsVC, animated: true, completion: nil)
        }
    }
    
    func saveImage(imageData: Data)  {
                
               FirebaseStorageService.manager.storeImage(image: imageData, completion: { [weak self] (result) in
                   switch result{
                   case .success(let url):

                       self?.imageURL = url
                   case .failure(let error):
                       //MARK: TODO - defer image not save alert, try again later. maybe make VC "dirty" to allow user to move on in nav stack
                       print(error)
                   }
               })
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
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
    
    private func presentPhotoPickerController() {
        DispatchQueue.main.async{
            let imagePickerViewController = UIImagePickerController()
            imagePickerViewController.delegate = self
            imagePickerViewController.sourceType = .photoLibrary
            imagePickerViewController.allowsEditing = true
            imagePickerViewController.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePickerViewController, animated: true, completion: nil)
        }
    }

}
extension CreateFoodVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.editedImage] as? UIImage else {
//            //MARK: TODO - handle couldn't get image :(
//            return
//        }
        
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            
            print("Error")
            
            return}
        self.image = originalImage
        
        guard let imageData = originalImage.jpegData(compressionQuality: 1) else {
            //MARK: TODO - gracefully fail out without interrupting UX
            return
        }
        
        dump(imageData)
        saveImage(imageData: imageData)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
