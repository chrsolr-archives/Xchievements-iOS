import UIKit
import Parse
import Alamofire
import AlamofireImage

class GameInfoVC: UIViewController {
    
    @IBOutlet weak var GameImageIV: UIImageView!
    @IBOutlet weak var GameTitleLB: UILabel!
    
    var game: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor("#1A1A1A")
        
        GameImageIV.af_setImageWithURL(NSURL(string: self.game["bannerImageUrl"] as! String)!)
        GameTitleLB.text = self.game["title"] as? String
    }
}
