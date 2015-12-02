//
//  Common.swift
//  xchievements
//
//  Created by Christian Soler on 11/29/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import Foundation
import UIKit

class Common {
    static let PARSE_APP_ID = "ZbsmNrnAoWvV4miJsVzkr4qwSlodOyFzhYWHECbI"
    static let PARSE_CLIENT_ID = "m7OKzx9QpP0feloktBKxlBIJXcjCNSWvI4H4LOJN"
    static let XBOX_API_API_KEY = "c298a7edee735d5559a219b0020a60fb9bb657dc"
    static let PRIMARY_COLOR = UIColor("#1A1A1A")
    static let SECONDARY_COLOR = UIColor("#333333")
    static let ACCENT_COLOR = UIColor("#f96816")
    
    /**
     Display Popup
    */
    static func dialogAlert(context: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        context.presentViewController(alert, animated: true, completion: nil)
    }
}
