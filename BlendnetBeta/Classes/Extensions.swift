//
//  Extensions.swift
//  Blendnet-Test
//
//  Created by Faisal M. Lalani on 2/4/19.
//

import UIKit

extension UIView {
    
    /**
     *  Simplifies adding constraints to views.
     */
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, paddingCenterX: CGFloat, paddingCenterY: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let centerX = centerX {
            
            centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX).isActive = true
        }
        
        if let centerY = centerY {
            
            centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY).isActive = true
        }
        
        if width != 0 {
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
