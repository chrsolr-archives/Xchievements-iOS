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
        self.tableView.backgroundColor = Common.PRIMARY_COLOR
        
        self.refreshControl?.tintColor = UIColor("#ffffff")
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.getLatestGames()
        
        self.loginButton = self.navigationItem.rightBarButtonItem
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            self.navigationItem.rightBarButtonItem = nil
            self.tabBarController?.tabBar.items![2].enabled = true
            self.tabBarController?.tabBar.items![2].title = PFUser.currentUser()!["gamertag"] as? String
        } else {
            self.navigationItem.rightBarButtonItem = self.loginButton
            self.tabBarController?.tabBar.items![2].enabled = false
        }
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
    
    func refresh(sender: AnyObject){
        self.lastCellIndexShowned = 0
        self.getLatestGames()
    }
}
