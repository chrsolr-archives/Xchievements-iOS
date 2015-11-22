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


extension UIImageView {
    public func imageFromUrl(url: String) {
        Alamofire.request(.GET, url).response { (request, response, data, error) in
            self.image = UIImage(data: data!)
        }
    }
}