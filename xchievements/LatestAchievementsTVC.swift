import UIKit
import Parse
import Alamofire
import AlamofireImage

class LatestAchievementsTVC: UITableViewController {
    
    var loginButton: UIBarButtonItem!
    var lastCellIndexShowned = 0
    var bannerUrl: String = ""
    var games = [PFObject]()
    var banner: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 315.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = UIColor("#1A1A1A")
        
        self.refreshControl?.tintColor = UIColor("#ffffff")
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.getLatestGames()
        
        loginButton = self.navigationItem.rightBarButtonItem
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        self.scrollViewDidScroll(nil)
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
        
        self.removeDividerPadding(cell)
        
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
    
    
    override func scrollViewDidScroll(scrollView: (UIScrollView!)) {
//        let visibleCells = self.tableView.visibleCells as! [GameTVCC]
//        
//        for cell in visibleCells  {
//            cell.cellOnTableView(self.tableView, didScrollOnView: self.view)
//        }
        
//                let visibleCells = self.tableView.visibleCells as! [GameTVCC]
        
//                for cell in visibleCells  {
                    //cell.GameArtworkIV.frame.origin.y = min(-30, -scrollView.contentOffset.y / 2.0)
//                    cell.GameArtworkIV.frame.origin.y = cell.GameArtworkIV.frame.origin.y - 0.1
//                    cell.GameArtworkIV.frame.origin.x = cell.GameArtworkIV.frame.origin.x - 0.1
//                    cell.GameArtworkIV.frame.size.height = cell.GameArtworkIV.frame.size.height + 0.2
//                    cell.GameArtworkIV.frame.size.width = cell.GameArtworkIV.frame.size.width + 0.2
                    
//                    print(-scrollView.contentOffset.y)
//                }
        
        
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
    
    private func getLatestGames(){
        ParseHandler.getLatestGames { (games, error, success) -> Void in
            if (success) {
                self.games = games
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            } else {
                print("\(error)")
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
    
    func refresh(sender: AnyObject){
        self.lastCellIndexShowned = 0
        self.getLatestGames()
    }
}
