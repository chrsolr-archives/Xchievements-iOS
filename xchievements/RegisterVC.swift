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
            Common.dialogAlert(self, title: "Check Gamertag", message: "Gamertag cannot be empty.")
            return
        }
        
        guard let email = EmailTextField.text where EmailTextField.text?.characters.count > 5 else {
            Common.dialogAlert(self, title: "Check Email", message: "Email must be atleast 6 characters long.")
            return
        }
        
        guard let password = PasswordTextField.text where PasswordTextField.text?.characters.count > 5 && PasswordTextField.text == ConfirmPasswordTextField.text else {
            Common.dialogAlert(self, title: "Check Password", message: "Please check your password.")
            return
        }
        
        ParseHandler.register(gamertag, email: email, password: password, completion: {
            (success, message) -> Void in
            
            if (success) {
                self.navigationController?.popToRootViewControllerAnimated(true)
            } else {
                Common.dialogAlert(self, title: "Error", message: message)
            }
        })
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
}
