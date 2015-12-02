import UIKit
import Parse

class ParentGameVC: UIViewController {
    
    @IBOutlet weak var GameInfoViewController: UIView!
    @IBOutlet weak var AchievementsViewController: UIView!
    
    var game: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.game["title"] as? String
    }
    
    @IBAction func switchTabs(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            self.GameInfoViewController.hidden = false
            self.AchievementsViewController.hidden = true
        case 1:
            self.GameInfoViewController.hidden = true
            self.AchievementsViewController.hidden = false
        default:
            self.GameInfoViewController.hidden = false
            self.AchievementsViewController.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "GameInfoSegue" {
                let gameInfoVC = segue.destinationViewController as? GameInfoVC
                gameInfoVC!.game = self.game
            }
            
            if identifier == "AchievementsSegue" {
                let achievementsVC = segue.destinationViewController as? AchievementsVC
                achievementsVC!.game = self.game
            }
        }
    }
    
    enum TabIndex : Int {
        case GameInfoTab = 0
        case AchievementsTab = 1
    }
}