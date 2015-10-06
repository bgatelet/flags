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
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBAction func playButton(sender: UIButton) {
        var identifier: String
        
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
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func ratioButton(sender: UIButton) {
        var identifier: String
        
        if sender.titleLabel!.text == "Ratio Flag" {
            identifier = "flagPlay"
        } else {
            identifier = "namePlay"
        }
        
        let ac = UIAlertController(title: nil, message: "choose game type", preferredStyle: .ActionSheet)
        
        let twentyFive = UIAlertAction(title: "< 25%", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.orderedKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let fifty = UIAlertAction(title: "< 55%", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.orderedKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let seventyFive = UIAlertAction(title: "< 75%", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.gameKeys = Countries.orderedKeys
            self.performSegueWithIdentifier(identifier, sender: self)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        ac.addAction(twentyFive)
        ac.addAction(fifty)
        ac.addAction(seventyFive)
        ac.addAction(cancel)
        
        self.presentViewController(ac, animated: true, completion: nil)
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
        } else if segue.identifier == "namePlay" {
            let gameController = segue.destinationViewController as! NameGameController
            gameController.gameType = gameKeys
        }
    }

}
