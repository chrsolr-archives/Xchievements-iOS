//
//  LoginVC.swift
//  xchievements
//
//  Created by Christian Soler on 11/22/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordTextField.delegate = self;
        EmailTextField.delegate = self;
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    @IBAction func login(sender: AnyObject) {
        
        guard let email = EmailTextField.text where EmailTextField.text?.characters.count > 5 else {
            self.alertError("Email must be atleast 6 characters long.")
            return
        }
        
        guard let password = PasswordTextField.text where PasswordTextField.text?.characters.count > 5 else {
            self.alertError("Please check your password.")
            return
        }

        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.navigationController!.popViewControllerAnimated(true)
            } else {
                self.alertError("Something when wrong while logging you in. Please check your credentials.")
            }
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case EmailTextField:
            PasswordTextField.becomeFirstResponder()
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
