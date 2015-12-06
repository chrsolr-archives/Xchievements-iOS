//
//  AchievementsVC.swift
//  xchievements
//
//  Created by Christian Soler on 11/26/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class AchievementsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lastCellIndexShowned = 0
    var game: PFObject!
    var achievements = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getAchievements()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let data = self.achievements[indexPath.row]
        let bannerIV = cell.viewWithTag(1) as! UIImageView
        let titleLB = cell.viewWithTag(2) as! UILabel
        let descriptionLB = cell.viewWithTag(3) as! UILabel
        
        bannerIV.image = nil
        bannerIV.af_setImageWithURL(NSURL(string: data["artworkUrl"] as! String)!)
        titleLB.text = data["title"] as? String
        descriptionLB.text = data["description"] as? String
        
        Common.removeDividerPadding(cell)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.achievements.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row >= self.lastCellIndexShowned) {
            
            cell.alpha = 0
            
            UIView.animateWithDuration(0.7, delay: 0.0, options: [.AllowUserInteraction], animations: { () -> Void in
                cell.alpha = 1
                }, completion: nil)
            
            self.lastCellIndexShowned++
        }
    }
    
    private func getAchievements(){
        
        ParseHandler.getGameAchievements(self.game["gameId"] as! String) { (achievements, error, success) -> Void in
            
            if (success) {
                self.achievements = achievements
                self.tableView.reloadData()
            } else {
                print("\(error)")
            }
        }
    }
}
