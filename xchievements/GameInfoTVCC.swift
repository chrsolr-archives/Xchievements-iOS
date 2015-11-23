//
//  GameInfoTVCC.swift
//  xchievements
//
//  Created by Christian Soler on 11/22/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class GameInfoTVCC: UITableViewCell {

    @IBOutlet weak var CoverImageView: UIImageView!
    @IBOutlet weak var PublisherLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var GenreLabel: UILabel!
    @IBOutlet weak var DeveloperLabel: UILabel!
    
    @IBOutlet weak var USAReleaseLabel: UILabel!
    
    
    
    func configureCellWith(game: PFObject!){
        if let gameInfo = game {
            let genres = gameInfo.objectForKey("genre") as! [String]
            let releases = gameInfo.objectForKey("releases") as! [AnyObject]
            
            CoverImageView.imageFromUrl(gameInfo.objectForKey("imageUrl") as! String)
            TitleLabel.text = gameInfo.objectForKey("title") as? String
            PublisherLabel.text = gameInfo.objectForKey("publisher") as? String
            DeveloperLabel.text = gameInfo.objectForKey("developer") as? String
            GenreLabel.text = genres.joinWithSeparator(" / ")
            
            for release in releases {
                if release["region"] as? String == "usa" {
                    USAReleaseLabel.text = release["date"] as? String
                }
            }
            
            print(gameInfo)
        }
    }
}
