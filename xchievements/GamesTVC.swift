//
//  GamesTVC.swift
//  xchievements
//
//  Created by Christian Soler on 12/5/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class GamesTVC: UITableViewController {
    
    var lastCellIndexShowned = 0
    var games = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 315.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = UIColor("#1A1A1A")
        
        self.refreshControl?.tintColor = UIColor("#ffffff")
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        self.getGames()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GameTVCC
        
        let data = self.games[indexPath.row]
        cell.GameArtworkIV.image = nil
        cell.GameArtworkIV.af_setImageWithURL(NSURL(string: data["bannerUrl"] as! String)!)
        cell.GameTitleLB.text = data["title"] as? String
        
        self.tableView.rowHeight = 315.0
        
        Common.removeDividerPadding(cell)
        
        return cell

    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row >= self.lastCellIndexShowned) {
            
            cell.alpha = 0
            
            UIView.animateWithDuration(0.7, delay: 0.0, options: [.AllowUserInteraction], animations: { () -> Void in
                cell.alpha = 1
                }, completion: nil)
            
            self.lastCellIndexShowned++
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "GameDetailsSegue" {
                let gameDetailsVC = segue.destinationViewController as? GameDetailsVC
                
                if let index = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                    gameDetailsVC!.game = self.games[index.row]
                }
            }
        }
    }
    
    private func getGames(){
        ParseHandler.getGames("A") { (games, error, success) -> Void in
            if (success) {
                self.games = games
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            } else {
                print("\(error)")
            }
        }
    }
    
    func refresh(sender: AnyObject){
        self.lastCellIndexShowned = 0
        self.getGames()
    }

}
