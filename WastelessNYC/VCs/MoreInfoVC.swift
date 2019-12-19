//
//  MoreInfoVC.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class MoreInfoVC: UIViewController {
    
    var foodList = [Food](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var extendedExpiration: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
    tableView.dataSource = self
    tableView.delegate = self
    foodList = getFoodGuidelines()
   // loadData()
    //FoodGuidelines
  //  print(foodList.count)
  //  dump(foodList)

        // Do any additional setup after loading the view.
    }
    

  private func getFoodGuidelines() -> [Food] {
      guard let fileName = Bundle.main.path(forResource: "ExpirationGuidelines", ofType: "json")
        else {fatalError()}
      let fileURL = URL(fileURLWithPath: fileName)
      do {
        let data = try Data(contentsOf: fileURL)
        let food = try
          JSONDecoder().decode(FoodGuidelines.self, from: data)
        
          return food.Categories.map {$0.data }
         
      } catch {
        fatalError("\(error)")
      }
    }
    
//    func loadData() {
//
//        guard let pathToData = Bundle.main.path(forResource: "austell2", ofType: "json")
//            else {
//                fatalError("austell.json file not found")
//        }
//        let internalUrl = URL(fileURLWithPath: pathToData)
//        do {
//            let data = try Data(contentsOf: internalUrl)
//            let signsFromJSON = try
//                signs = Welcome.getStreetSigns()
//        } catch {
//            print(error)
//        }
//    }
    func setUpLabels(){
        foodName.text = "Type of Food"
        extendedExpiration.text = "Date Extension"
        infoText.text = "An expired date does not necessarily mean that the food needs to be thrown out.  These Expiration Date Extensions are guidelines to help you determine if expired food can still be used.  Always use common sense and good judgment when determining if food is safe to eat and remember: 'When in doubt, throw it out!'"
    }
}


extension MoreInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return foodList.count


  }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }
//  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ExCell.rawValue) else
    {return UITableViewCell()}
    let food = foodList[indexPath.row]
    cell.textLabel?.text = food.foodItem
    cell.detailTextLabel?.text = food.dateExtension
    

    return cell
  }
  
  
  
}
