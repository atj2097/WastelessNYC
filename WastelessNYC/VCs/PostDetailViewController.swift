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
import Kingfisher


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
    
    private let locationManager = CLLocationManager()
    let initialLocation = CLLocation(latitude: 40.7552889, longitude: -73.9577348)
    let searchRadius: CLLocationDistance = 25


  override func viewDidLoad() {
        super.viewDidLoad()
    locationManager.delegate = self
        locationAuthorization()
        setUpData()
    
        // Do any additional setup after loading the view.
    }
    

    
  private func locationAuthorization() {
    let status = CLLocationManager.authorizationStatus()
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      mapViewLocation.showsUserLocation = true
      locationManager.requestLocation()
      locationManager.startUpdatingLocation()
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
    default:
      locationManager.requestWhenInUseAuthorization()
    }
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
        let imageURL = URL(string: post.imageURL)
        postImageView.kf.setImage(with: imageURL)
        foodName.text = post.title
        address.text = post.body
        date.text = post.dateCreated?.description
    }

}

extension PostDetailViewController: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location: \(locations.first)")
        }

    }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("authorization status change to \(status.rawValue)")

    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      locationManager.requestLocation()
    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}

