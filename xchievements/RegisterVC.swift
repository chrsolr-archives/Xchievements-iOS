//
//  RegisterVC.swift
//  xchievements
//
//  Created by Christian Soler on 11/24/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var GamertagTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GamertagTextField.delegate = self;
        EmailTextField.delegate = self;
        PasswordTextField.delegate = self;
        ConfirmPasswordTextField.delegate = self;
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    
    @IBAction func register(sender: AnyObject) {
        
        guard let gamertag = GamertagTextField.text where GamertagTextField.text?.characters.count > 0 else {
            self.alertError("Gamertag cannot be empty.")
            return
        }
        
        guard let email = EmailTextField.text where EmailTextField.text?.characters.count > 5 else {
            self.alertError("Email must be atleast 6 characters long.")
            return
        }
        
        guard let password = PasswordTextField.text where PasswordTextField.text?.characters.count > 5 && PasswordTextField.text == ConfirmPasswordTextField.text else {
            self.alertError("Please check your password.")
            return
        }
        
        let user = PFUser()
        user.username = email
        user.email = email
        user.password = password
        user["gamertag"] = gamertag
        user["postCount"] = 0
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                self.alertError((error.userInfo["error"] as? String)!)
            } else {
                let queryRole = PFRole.query()
                queryRole?.whereKey("name", equalTo:"User")
                queryRole?.getFirstObjectInBackgroundWithBlock({ (role: PFObject?, error: NSError?) -> Void in
                    if error == nil {
                        let roleToAddUser = role as! PFRole
                        
                        roleToAddUser.users.addObject(PFUser.currentUser()!)
                        roleToAddUser.saveInBackground()
                        
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }
                })
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case GamertagTextField:
            EmailTextField.becomeFirstResponder()
        case EmailTextField:
            PasswordTextField.becomeFirstResponder()
        case PasswordTextField:
            ConfirmPasswordTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func alertError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
