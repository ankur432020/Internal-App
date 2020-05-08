//
//  CustomSlider.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 07/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
        
        override func trackRect(forBounds bounds: CGRect) -> CGRect {
            let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 6.0))
            super.trackRect(forBounds: customBounds)
            return customBounds
        }
        

}
