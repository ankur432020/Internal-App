//
//  ContentCollectionViewCell.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 19/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var checkBox_Btn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var checkBoxView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
