//
//  LatestAchievementsTableViewCell.swift
//  xchievements
//
//  Created by Christian Soler on 11/21/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class LatestAchievementsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CoverImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AchievementsCountLabel: UILabel!
    @IBOutlet weak var CommentsCountLabel: UILabel!
    
    
    func configureCellWith(game: PFObject){
        self.TitleLabel.text = game.objectForKey("title") as? String
        self.AchievementsCountLabel.text = "\(game.objectForKey("achievementCount") as! Int) Achievements" 
        self.CoverImageView.imageFromUrl(game.objectForKey("imageUrl") as! String)
    }
}
