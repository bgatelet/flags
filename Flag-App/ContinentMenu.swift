//
//  ContinentMenu.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class ContinentMenu: UIViewController {
    
    var gameKeys = [String]()
    
    @IBAction func saButton(sender: AnyObject) {
        gameKeys = Countries.saKeys
        performSegueWithIdentifier("ContinentPlay", sender: self)
    }
    
    @IBAction func euButton(sender: AnyObject) {
        gameKeys = Countries.euKeys
        performSegueWithIdentifier("ContinentPlay", sender: self)
    }
    
    @IBAction func afButton(sender: AnyObject) {
        gameKeys = Countries.afKeys
        performSegueWithIdentifier("ContinentPlay", sender: self)
    }
    
    @IBAction func asButton(sender: AnyObject) {
        gameKeys = Countries.asKeys
        performSegueWithIdentifier("ContinentPlay", sender: self)
    }

    @IBAction func ocButton(sender: AnyObject) {
        gameKeys = Countries.ocKeys
        performSegueWithIdentifier("ContinentPlay", sender: self)
    }
    
    @IBAction func naButton(sender: AnyObject) {
        gameKeys = Countries.naKeys
        performSegueWithIdentifier("ContinentPlay", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ContinentPlay" {
            let gameController = segue.destinationViewController as! GameController
            gameController.gameType = gameKeys
        }
    }

}
