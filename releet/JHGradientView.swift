//
//  JHGradientView.swift
//  Gradient View editable in Interface Builder
//
//  Created by JHays on 2/20/15.
//  Copyright (c) 2015 Orbosphere. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class JHGradientView: UIView {
    
    @IBInspectable public var topColor: UIColor? {
        didSet {
            configureGradientView()
        }
    }
    @IBInspectable public var bottomColor: UIColor? {
        didSet {
            configureGradientView()
        }
    }
    @IBInspectable var startX: CGFloat = 0.0 {
        didSet{
            configureGradientView()
        }
    }
    @IBInspectable var startY: CGFloat = 1.0 {
        didSet{
            configureGradientView()
        }
    }
    @IBInspectable var endX: CGFloat = 0.0 {
        didSet{
            configureGradientView()
        }
    }
    @IBInspectable var endY: CGFloat = 0.0 {
        didSet{
            configureGradientView()
        }
    }
    
    override public class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configureGradientView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientView()
    }
    
    public override func tintColorDidChange() {
        super.tintColorDidChange()
        configureGradientView()
    }
    
    func configureGradientView() {
        
        let color1 = topColor ?? UIColor.clearColor() as UIColor
        let color2 = bottomColor ?? UIColor.clearColor() as UIColor
        let colors: Array <AnyObject> = [ color1.CGColor, color2.CGColor ]
        let layer = self.layer as! CAGradientLayer
        
        layer.colors = colors
        layer.startPoint = CGPointMake(startX, startY)
        layer.endPoint = CGPointMake(endX, endY)
        
    }
}