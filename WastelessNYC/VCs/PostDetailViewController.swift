//
//  PostDetailViewController.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit



class PostDetailViewController: UIViewController {
    var post: Post!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mapViewLocation: MKMapView!
    @IBOutlet weak var grabIt: UIButton!
    
    @IBAction func grabIt(_ sender: UIButton) {
        grabItAlertController()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    private func grabItAlertController() {
        let alertController = UIAlertController(title: "You can go pick up this item from this User ", message: "", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let alertActionTwo = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(alertActionTwo)
        alertController.modalPresentationStyle = .popover
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setUpData() {
    
    }

}
