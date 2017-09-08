//
//  CustomTableViewCell.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 09/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var dayString: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
