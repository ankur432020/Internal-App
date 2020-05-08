//
//  Common.swift
//  InternalApp
//
//  Created by AUGURS Technologies on 06/03/20.
//  Copyright © 2020 AUGURS Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // FOR GIVE SHADOW TO VIEW EXTERNAL
    func dropShadow(cRadius: CGFloat, bgColor: UIColor) {
        
        var shadowLayer: CAShapeLayer!
        let cornerRadius = cRadius
        let fillColor = bgColor
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowColor = UIColor.gray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: -1.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.65
            shadowLayer.shadowRadius = 6
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
     // FOR GIVE SHADOW TO VIEW EXTERNAL With BORDER
    func dropShadowWithBorder(borderWidth: CGFloat, borderColor: UIColor, shadowColor: UIColor, shadowRadius: CGFloat, shadowOffset: CGSize, shadowOpacity: Float ) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        
        
    }
    
}
extension UIView {
    
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        self.layer.addSublayer(gradientLayer)
    }
}
