import UIKit
import Parse
import Alamofire
import AlamofireImage

class GameDetailsVC: UIViewController {
    
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
        
        self.view.backgroundColor = Common.PRIMARY_COLOR
        self.title = self.game["title"] as? String
        
        let genres = self.game["genre"] as! [String]
        let releases = game["releases"] as! [AnyObject]

        GameImageIV.af_setImageWithURL(NSURL(string: self.game["bannerUrl"] as! String)!)
        GameTitleLB.text = self.game["title"] as? String
        GameAchievementsAmountLB.text = "\(self.game["achievementsCount"] as! Int)"
        GamerscoreLB.text = "\(self.game["gamerscore"] as! Int)"
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "GameAchievementsSegue" {
                let gameAchievementsVC = segue.destinationViewController as? AchievementsVC
                gameAchievementsVC!.game = self.game
            }
        }
    }
}
