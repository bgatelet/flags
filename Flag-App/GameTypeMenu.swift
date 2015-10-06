//
//  GameTypeMenu.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class GameTypeMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WorldPlay" {
            let gameController = segue.destinationViewController as! GameController
            gameController.gameType = Countries.allColumns["abbreviation"]!
        } 
//            else if segue.identifier == "USAPlay" {
//            let gameController = segue.destinationViewController as! GameController
//            gameController.gameType = Countries.usaKeys
//        }
    }

}
