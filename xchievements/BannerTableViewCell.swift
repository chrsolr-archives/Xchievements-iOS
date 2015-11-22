//
//  BannerTableViewCell.swift
//  xchievements
//
//  Created by Christian Soler on 11/21/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class BannerTableViewCell: UITableViewCell {
    @IBOutlet weak var BannerImageView: UIImageView!
    @IBOutlet weak var BannerTitleLabel: UILabel!
    
    @IBOutlet weak var BannerTitleBg: UIView!
    
    func configureCellWith(banner: PFObject){
        self.BannerTitleLabel.text = banner.objectForKey("game")!["title"] as? String
        self.BannerImageView.imageFromUrl(banner.objectForKey("imageUrl") as! String)
        self.BannerTitleBg.layerGradient()
    }
}
