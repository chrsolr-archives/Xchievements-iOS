//
//  UIViewExtensions.swift
//  xchievements
//
//  Created by Christian Soler on 11/21/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func layerGradient() {
        let gradient = CAGradientLayer()
        
        gradient.colors = [UIColor.clearColor().CGColor, Common.PRIMARY_COLOR.CGColor]
        //gradient.locations = [0.0 , 1.0]
        gradient.frame = self.bounds
        //gradient.frame = CGRect(x: 0.0, y: self.frame.size.height/4, width: self.frame.size.width, height: self.frame.size.height)
        
        self.layer.insertSublayer(gradient, atIndex: 0)
    }
}