import UIKit
import Parse

class LatestAchievementsTVC: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    var loginButton: UIBarButtonItem!
    var bannerUrl: String = ""
    var games = [PFObject]()
    var banner: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.estimatedRowHeight = 184.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.backgroundColor = UIColor.whiteColor()
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.getBanner()
        
        loginButton = self.navigationItem.rightBarButtonItem
        
        //PFUser.logOut()
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            self.navigationItem.rightBarButtonItem = nil
        }
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
            let cell = tableView.dequeueReusableCellWithIdentifier("GameBanner", forIndexPath: indexPath)
            
            if let data = self.banner {
                let bannerImageView = cell.viewWithTag(1) as! UIImageView
                let titleLabel = cell.viewWithTag(2) as! UILabel
                
                bannerImageView.imageFromUrl(data["game"]["bannerImageUrl"] as! String)
                titleLabel.text = data["game"]["title"] as? String
            }
            
            self.tableView.rowHeight = 215.0
            
            self.removeDividerPadding(cell)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Achievements", forIndexPath: indexPath)
            
            let data = self.games[indexPath.row - 1]
            let coverImageView = cell.viewWithTag(1) as! UIImageView
            let titleLabel = cell.viewWithTag(2) as! UILabel
            let gamerscoreLabel = cell.viewWithTag(3) as! UILabel
            let achAmountLabel = cell.viewWithTag(4) as! UILabel
            
            
            coverImageView.imageFromUrl(data["imageUrl"] as! String)
            titleLabel.text = data["title"] as? String
            gamerscoreLabel.text = "\(data["gamerScore"] as! Int) Gamerscore"
            achAmountLabel.text = "\(data["achievementCount"] as! Int) Achievements"

            self.removeDividerPadding(cell)
            
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "GameInfoSegue" {
                let gameInfoVC = segue.destinationViewController as? GameInfoVC
                
                if let index = self.tableview.indexPathForCell(sender as! UITableViewCell) {
                    gameInfoVC!.game = self.games[index.row - 1]
                }
            }
        }
    }
    
    private func getBanner(){
        let query = PFQuery(className:"Banners")
        query.includeKey("game")
        query.orderByDescending("createdAt")
        query.limit = 1
        query.whereKey("show", equalTo: true)
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
        query.whereKey("show", equalTo: true)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.games = objects!
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
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
    
    func refresh(sender: AnyObject){
        self.getBanner()
    }
}
