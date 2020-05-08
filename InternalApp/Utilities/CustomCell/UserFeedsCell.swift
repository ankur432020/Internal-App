//
//  UserFeedsCell.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 07/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class UserFeedsCell: UITableViewCell {

    @IBOutlet weak var userStatus_lbl: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var next_btn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
