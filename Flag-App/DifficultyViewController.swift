//
//  DifficultyViewController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

enum Difficulty: Int {
    case Easy = 2
    case Medium = 4
    case Hard = 6
    case Extreme = 8
}

class DifficultyViewController: UIViewController {
    
    @IBOutlet weak var buttonEasy: UIButton!
    @IBOutlet weak var buttonMedium: UIButton!
    @IBOutlet weak var buttonHard: UIButton!
    @IBOutlet weak var buttonExtreme: UIButton!
    
    @IBAction func easy(sender: AnyObject) {
        buttonColor(.Easy)
    }
    
    @IBAction func medium(sender: AnyObject) {
        buttonColor(.Medium)
    }
    
    @IBAction func hard(sender: AnyObject) {
        buttonColor(.Hard)
    }
    
    @IBAction func extreme(sender: AnyObject) {
        buttonColor(.Extreme)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Difficulty"
        buttonColor(Level.difficulty)
    }
    
    func buttonColor(difficulty: Difficulty) {
        switch difficulty {
        case .Easy:
            Level.difficulty = Difficulty.Easy
            buttonEasy.backgroundColor = UIColor.redColor()
            buttonMedium.backgroundColor = UIColor.whiteColor()
            buttonHard.backgroundColor = UIColor.whiteColor()
            buttonExtreme.backgroundColor = UIColor.whiteColor()
        case .Medium:
            Level.difficulty = Difficulty.Medium
            buttonEasy.backgroundColor = UIColor.whiteColor()
            buttonMedium.backgroundColor = UIColor.redColor()
            buttonHard.backgroundColor = UIColor.whiteColor()
            buttonExtreme.backgroundColor = UIColor.whiteColor()
        case .Hard:
            Level.difficulty = Difficulty.Hard
            buttonEasy.backgroundColor = UIColor.whiteColor()
            buttonMedium.backgroundColor = UIColor.whiteColor()
            buttonHard.backgroundColor = UIColor.redColor()
            buttonExtreme.backgroundColor = UIColor.whiteColor()
        case .Extreme:
            Level.difficulty = Difficulty.Extreme
            buttonEasy.backgroundColor = UIColor.whiteColor()
            buttonMedium.backgroundColor = UIColor.whiteColor()
            buttonHard.backgroundColor = UIColor.whiteColor()
            buttonExtreme.backgroundColor = UIColor.redColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
