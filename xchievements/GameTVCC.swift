//
//  GameTVCC.swift
//  xchievements
//
//  Created by Christian Soler on 12/1/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit

class GameTVCC: UITableViewCell {

    @IBOutlet weak var GameArtworkIV: UIImageView!
    
    @IBOutlet weak var GameTitleLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellOnTableView(tableView: UITableView, didScrollOnView view: UIView) {
//        let rectInSubview = tableView.convertRect(self.frame, toView: view)
//        
//        let distanceFromCenter = (CGRectGetHeight(view.frame) / 2) - CGRectGetMinY(rectInSubview)
//        let diff = CGRectGetHeight(GameArtworkIV.frame) - CGRectGetHeight(self.frame)
//        let move = (distanceFromCenter / CGRectGetHeight(view.frame)) * diff
//        
//        var imageRect = GameArtworkIV.frame
//        imageRect.origin.y = -(diff/2) + move
//        GameArtworkIV.frame = imageRect
    }
}
