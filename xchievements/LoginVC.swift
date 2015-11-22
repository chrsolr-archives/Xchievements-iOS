//
//  LoginVC.swift
//  xchievements
//
//  Created by Christian Soler on 11/22/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: AnyObject) {

        PFUser.logInWithUsernameInBackground(EmailTextField.text!, password: PasswordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.navigationController!.popViewControllerAnimated(true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Something when wrong while logging you in. Please check your credentials.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }

    }
}
