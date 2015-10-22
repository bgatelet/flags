//
//  MainMenu.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/2/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var seenLabel: UILabel!

    @IBAction func dificultyButton(sender: UIButton) {
        let ac = UIAlertController(title: "Difficulty", message: nil, preferredStyle: .ActionSheet)
        
        let easy = UIAlertAction(title: "easy", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Easy
            Level.save()
            self.changeDifficultyLabel()
        })
        
        let medium = UIAlertAction(title: "medium", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Medium
            Level.save()
            self.changeDifficultyLabel()
        })
        
        let hard = UIAlertAction(title: "hard", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Hard
            Level.save()
            self.changeDifficultyLabel()
        })
        
        let extreme = UIAlertAction(title: "extreme", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            Level.difficulty = Difficulty.Extreme
            Level.save()
            self.changeDifficultyLabel()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        ac.addAction(easy)
        ac.addAction(medium)
        ac.addAction(hard)
        ac.addAction(extreme)
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeDifficultyLabel()
    }
    
    func changeDifficultyLabel() {
        difficultyLabel.text = "Difficulty: \(Level.difficulty)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
