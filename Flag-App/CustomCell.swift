//
//  CustomCell.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/22/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var flagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
