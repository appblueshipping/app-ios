//
//  CustomCell.swift
//  tracking
//
//  Created by Jonatha Lima on 12/05/17.
//  Copyright © 2017 Blue Shipping do Brasil. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UITextView!
    @IBOutlet weak var imgUpload: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var separatorViewTwo: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
