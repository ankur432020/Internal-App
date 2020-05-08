//
//  EquipmentMaintenanceCell.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 06/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class EquipmentMaintenanceCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var reason_lbl: UILabel!
    @IBOutlet weak var count_lbl: UILabel!
    
    @IBOutlet weak var equipment_lbl: UILabel!
    @IBOutlet weak var mainTitle_lbl: UILabel!
    
    @IBOutlet weak var btn_next: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
