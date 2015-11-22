//
//  LatestAchievementsTVC.swift
//  xchievements
//
//  Created by Christian Soler on 11/21/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class LatestAchievementsTVC: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    var bannerUrl: String = ""
    var games = [PFObject]()
    var banner: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.estimatedRowHeight = 184.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.backgroundColor = UIColor.whiteColor()
        
        self.getBanner()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.games.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("GameBanner", forIndexPath: indexPath) as! BannerTableViewCell
            
            cell.configureCellWith(self.banner)
            
            self.tableView.rowHeight = 215.0
            
            self.removeDividerPadding(cell)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Achievements", forIndexPath: indexPath) as! LatestAchievementsTableViewCell
            
            cell.configureCellWith(self.games[indexPath.row - 1])
            
            self.removeDividerPadding(cell)
            
            return cell
        }
    }
    
    private func getBanner(){
        let query = PFQuery(className:"Banners")
        query.includeKey("game")
        query.orderByDescending("createdAt")
        query.limit = 1
        query.getFirstObjectInBackgroundWithBlock { (object:PFObject?, error:NSError?) -> Void in
            
            if error == nil {
                self.banner = object!
                self.getLatestGames()
            }
        }
    }
    
    private func getLatestGames(){
        let query = PFQuery(className:"Games")
        query.orderByDescending("createdAt")
        query.limit = 26
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.games = objects!
                self.tableView.reloadData()
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    private func removeDividerPadding(cell: UITableViewCell){
        // Remove seperator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
}
