//
//  FoodCell.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var dateExpiration: UILabel!
    @IBOutlet weak var foodName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
