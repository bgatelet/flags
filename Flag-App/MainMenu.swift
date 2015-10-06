//
//  MainMenu.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/2/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {

    @IBAction func statsButton(sender: UIButton) {
        let ac = UIAlertController(title: "Difficulty", message: nil, preferredStyle: .ActionSheet)
        
        let easy = UIAlertAction(title: "easy", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Easy
        })
        
        let medium = UIAlertAction(title: "medium", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Medium
        })
        
        let hard = UIAlertAction(title: "hard", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Hard
        })
        
        let extreme = UIAlertAction(title: "extreme", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Extreme
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        ac.addAction(easy)
        ac.addAction(medium)
        ac.addAction(hard)
        ac.addAction(extreme)
        ac.addAction(cancel)
        
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
