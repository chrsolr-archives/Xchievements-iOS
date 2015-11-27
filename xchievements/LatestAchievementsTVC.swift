import UIKit
import Parse
import Alamofire
import AlamofireImage

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
        self.tableview.backgroundColor = UIColor("#1A1A1A")
        
        self.refreshControl?.tintColor = UIColor("#ffffff")
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.getLatestGames()
        
        loginButton = self.navigationItem.rightBarButtonItem
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() != nil) {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let data = self.games[indexPath.row]
        let bannerIV = cell.viewWithTag(1) as! UIImageView
        let titleLB = cell.viewWithTag(2) as! UILabel
        
        bannerIV.af_setImageWithURL(NSURL(string: data["bannerImageUrl"] as! String)!)
        titleLB.text = data["title"] as? String
        
        self.tableView.rowHeight = 315.0
        
        self.removeDividerPadding(cell)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "ParentGameSegue" {
                let gameInfoVC = segue.destinationViewController as? ParentGameVC
                
                if let index = self.tableview.indexPathForCell(sender as! UITableViewCell) {
                    gameInfoVC!.game = self.games[index.row]
                }
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
        self.getLatestGames()
    }
}
