//
//  UserCell.swift
//  WastelessNYC
//
//  Created by God on 12/19/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodAddress: UILabel!
    @IBOutlet weak var trashButton: UIButton!
    @IBAction func trashFunc(_ sender: UIButton) {
        self.isHidden = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
