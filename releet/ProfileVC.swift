//
//  ProfileVC.swift
//  releet
//
//  Created by Christian Soler on 12/13/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class ProfileVC: UIViewController {
    
    @IBOutlet weak var ProfileIV: UIImageView!
    @IBOutlet weak var GamertagLB: UILabel!
    @IBOutlet weak var GamerscoreLB: UILabel!
    @IBOutlet weak var PlayerRep: UILabel!
    
    var xuid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ProfileIV.backgroundColor = Common.ACCENT_COLOR
        self.ProfileIV.circularImage()
        self.ProfileIV.border(2, color: Common.ACCENT_COLOR)
        
        self.displayContent(PFUser.currentUser()!)
    }
    
    @IBAction func logout(sender: UIBarButtonItem) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            self.tabBarController?.tabBar.items![2].title = "Profile"
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    private func displayContent(user: PFUser){
        self.title = user["gamertag"] as? String
        self.ProfileIV.af_setImageWithURL(NSURL(string: user["gamerpic"] as! String)!)
        self.GamertagLB.text = user["gamertag"] as? String
    }
}
