//
//  LovelistCell.swift
//  Prelo
//
//  Created by Fachri Work on 11/17/17.
//  Copyright © 2017 Decadev. All rights reserved.
//

import UIKit

class LovelistCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameView: UILabel!
    @IBOutlet weak var productPriceView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
