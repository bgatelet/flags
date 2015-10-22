//
//  PlayMenu.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class PlayMenu: UIViewController {
    
    var gameKeys = [String]()
    var isRatioBool = false
    var ratioCheck = 0
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var seenLabel: UILabel!
    
    @IBOutlet weak var ratioFlagButton: UIButton!
    @IBOutlet weak var ratioNameButton: UIButton!
    
    @IBAction func playButton(sender: UIButton) {
        var identifier: String
        
        isRatioBool = false
        ratioCheck = 100
        
        if sender.titleLabel!.text == "Flag" {
            identifier = "flagPlay"
        } else {
            identifier = "namePlay"
        }
        
        let ac = UIAlertController(title: nil, message: "choose game type", preferredStyle: .ActionSheet)
        
        let world = UIAlertAction(title: "World", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.orderedKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let af = UIAlertAction(title: "Africa", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.afKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        let asia = UIAlertAction(title: "Asia", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.asKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        let eu = UIAlertAction(title: "Europe", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.euKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        let na = UIAlertAction(title: "North America", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.naKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        let oc = UIAlertAction(title: "Oceania", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.ocKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        let sa = UIAlertAction(title: "South America", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.saKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let usa = UIAlertAction(title: "USA", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.usKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        ac.addAction(world)
        ac.addAction(af)
        ac.addAction(asia)
        ac.addAction(eu)
        ac.addAction(na)
        ac.addAction(oc)
        ac.addAction(sa)
        ac.addAction(usa)
        ac.addAction(cancel)
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func ratioButton(sender: UIButton) {
        var identifier: String
        
        isRatioBool = true
        
        if sender.titleLabel!.text == "Ratio Flag" {
            identifier = "flagPlay"
        } else {
            identifier = "namePlay"
        }
        
        let ac = UIAlertController(title: nil, message: "choose game type", preferredStyle: .ActionSheet)
        
        let twentyFive = UIAlertAction(title: "< 25%", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Ratios.underTwo
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let fifty = UIAlertAction(title: "< 50%", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Ratios.underFifty
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let seventyFive = UIAlertAction(title: "< 75%", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Ratios.underSeven
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        if ratioCheck <= 25 { ac.addAction(twentyFive) }
        if ratioCheck <= 50 { ac.addAction(fifty) }
        if ratioCheck <= 75 { ac.addAction(seventyFive) }
        ac.addAction(cancel)
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        Ratios.updateTotal()
        seenLabel.text = "Seen: \(Ratios.seen.count)/\(Countries.allKeys)"
        
        if Countries.unlocked == true {
            ratioFlagButton.enabled = true
            ratioNameButton.enabled = true
        } else {
            ratioFlagButton.enabled = false
            ratioNameButton.enabled = false
        }
        
        if Ratios.underTwo.count > Level.difficulty.rawValue {
            ratioCheck = 25
        } else if Ratios.underFifty.count > Level.difficulty.rawValue {
            ratioCheck = 50
        } else if Ratios.underSeven.count > Level.difficulty.rawValue {
            ratioCheck = 75
        } else {
            ratioCheck = 100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        difficultyLabel.text = "Difficulty: \(Level.difficulty)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "flagPlay" {
            let gameController = segue.destinationViewController as! GameController
            gameController.gameType = gameKeys
            gameController.isRatio = isRatioBool
            gameController.ratioType = ratioCheck
        } else if segue.identifier == "namePlay" {
            let gameController = segue.destinationViewController as! NameGameController
            gameController.gameType = gameKeys
            gameController.isRatio = isRatioBool
            gameController.ratioType = ratioCheck
        }
    }

}
