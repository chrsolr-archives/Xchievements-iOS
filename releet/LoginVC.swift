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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    @IBAction func login(sender: AnyObject) {
        
        guard let email = EmailTextField.text where EmailTextField.text?.characters.count > 5 else {
            Common.dialogAlert(self, title: "Check Email", message: "Email must be atleast 6 characters long.")
            return
        }
        
        guard let password = PasswordTextField.text where PasswordTextField.text?.characters.count > 5 else {
            Common.dialogAlert(self, title: "Check Password", message: "Please check your password.")
            return
        }

        ParseHandler.login(email, password: password, completion: {(success) -> Void in
            if (success) {
                self.navigationController!.popViewControllerAnimated(true)
            } else {
                Common.dialogAlert(self, title: "Error", message: "Something when wrong while logging you in. Please check your credentials.")
            }
        })
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
}
