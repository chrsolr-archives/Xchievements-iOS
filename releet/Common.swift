import Foundation
import UIKit

class Common {
    static let PARSE_APP_ID = "ZbsmNrnAoWvV4miJsVzkr4qwSlodOyFzhYWHECbI"
    static let PARSE_CLIENT_ID = "m7OKzx9QpP0feloktBKxlBIJXcjCNSWvI4H4LOJN"
    static let XBOX_API_API_KEY = "c298a7edee735d5559a219b0020a60fb9bb657dc"
    static let PRIMARY_COLOR = UIColor("#097c9c")
    static let SECONDARY_COLOR = UIColor("#9425f2")
    static let ACCENT_COLOR = UIColor("#f9d406")
    static let ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".characters.map { String($0) }
    
    /**
     Display Popup
    */
    static func dialogAlert(context: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        context.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func parallaxEffectOnBackground(imageView: UIImageView) {
        let relativeMotionValue = 50
        let verticalMotionEffect : UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -relativeMotionValue
        verticalMotionEffect.maximumRelativeValue = relativeMotionValue
        
        let horizontalMotionEffect : UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -relativeMotionValue
        horizontalMotionEffect.maximumRelativeValue = relativeMotionValue
        
        let group : UIMotionEffectGroup = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        imageView.addMotionEffect(group)
    }
    
    static func removeDividerPadding(cell: UITableViewCell){
        // Remove seperator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
}
