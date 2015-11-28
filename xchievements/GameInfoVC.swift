import UIKit
import Parse
import Alamofire
import AlamofireImage

class GameInfoVC: UIViewController {
    
    @IBOutlet weak var GameImageIV: UIImageView!
    @IBOutlet weak var GameTitleLB: UILabel!
    @IBOutlet weak var GameAchievementsAmountLB: UILabel!
    @IBOutlet weak var GamerscoreLB: UILabel!
    @IBOutlet weak var DeveloperLB: UILabel!
    @IBOutlet weak var PublisherLB: UILabel!
    @IBOutlet weak var GenreLB: UILabel!
    @IBOutlet weak var UsaReleaseLB: UILabel!
    @IBOutlet weak var DescriptionLB: UILabel!
    
    var game: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor("#1A1A1A")
        
        let genres = self.game["genre"] as! [String]
        let releases = game["releases"] as! [AnyObject]
        
        GameImageIV.af_setImageWithURL(NSURL(string: self.game["bannerImageUrl"] as! String)!)
        GameTitleLB.text = self.game["title"] as? String
        GameAchievementsAmountLB.text = "\(self.game["achievementCount"] as! Int)"
        GamerscoreLB.text = "\(self.game["gamerScore"] as! Int)"
        DeveloperLB.text = self.game["developer"] as? String
        PublisherLB.text = self.game["publisher"] as? String
        GenreLB.text = genres.joinWithSeparator(" / ")
        DescriptionLB.text = self.game["description"] as? String
        
        for release in releases {
            if release["region"] as? String == "usa" {
                UsaReleaseLB.text = release["date"] as? String
            }
        }
    }
}
