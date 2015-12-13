//
//  UIImageExtensions.swift
//  xchievements
//
//  Created by Christian Soler on 11/21/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage


extension UIImageView {
        public func imageFromUrl(url: String) {
//            Alamofire.request(.GET, url)
//                .responseImage { response in
//                    if let image = response.result.value {
//                        self.image = image
//                    }
//            }
        }
    
    public func circularImage(){
        self.layer.cornerRadius = self.frame.size.width / 2;
    }
    
    public func border(size: Int, color: UIColor){
        self.layer.borderWidth = CGFloat(size)
        self.layer.borderColor = color.CGColor
    }
}