//
//  GamesTVC.swift
//  xchievements
//
//  Created by Christian Soler on 12/5/15.
//  Copyright © 2015 Christian Soler. All rights reserved.
//

import UIKit
import Parse

class GamesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var BrowseNavBT: UIBarButtonItem!
    @IBOutlet weak var dummyTF: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let alphabet = Common.ALPHABET
    var browsePicker = UIPickerView()
    var isPickerHidden = true
    var lastCellIndexShowned = 0
    var games = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.browsePicker.delegate = self
        self.browsePicker.dataSource = self
        self.browsePicker.backgroundColor = Common.PRIMARY_COLOR
        self.dummyTF.inputView = self.browsePicker
        self.dummyTF.text = alphabet[0]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 315.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = Common.PRIMARY_COLOR

        self.getGames(self.dummyTF.text!)
    }
    
    @IBAction func selectAlphabetLetterPicker(sender: AnyObject) {
        if self.isPickerHidden {
            self.dummyTF.becomeFirstResponder()
            self.isPickerHidden = false
            self.BrowseNavBT.title = "Done"
        } else {
            self.dummyTF.resignFirstResponder()
            self.getGames(self.dummyTF.text!)
            self.BrowseNavBT.title = "Browse"
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GameTVCC
        
        let data = self.games[indexPath.row]
        cell.GameArtworkIV.image = nil
        cell.GameArtworkIV.af_setImageWithURL(NSURL(string: data["bannerUrl"] as! String)!)
        cell.GameTitleLB.text = data["title"] as? String
        
        self.tableView.rowHeight = 315.0
        
        Common.removeDividerPadding(cell)
        
        return cell

    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row >= self.lastCellIndexShowned) {
            
            cell.alpha = 0
            
            UIView.animateWithDuration(0.7, delay: 0.0, options: [.AllowUserInteraction], animations: { () -> Void in
                cell.alpha = 1
                }, completion: nil)
            
            self.lastCellIndexShowned++
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.alphabet.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.alphabet[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.dummyTF.text = self.alphabet[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.alphabet[row], attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "GameDetailsSegue" {
                let gameDetailsVC = segue.destinationViewController as? GameDetailsVC
                
                if let index = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                    gameDetailsVC!.game = self.games[index.row]
                }
            }
        }
    }
    
    private func getGames(letter: String){
        ParseHandler.getGames(letter) { (games, error, success) -> Void in
            if (success) {
                self.games = games
                self.tableView.reloadData()
                self.isPickerHidden = true
                self.tableView.setContentOffset(CGPointZero, animated: true)
            } else {
                print("\(error)")
            }
        }
    }
}
