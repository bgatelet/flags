//
//  NameGameController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/6/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import GameKit
import UIKit

class NameGameController: UIViewController {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet var gameButtons: [UIButton]!
    
    @IBAction func button0(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button1(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button2(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button3(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button4(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button5(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button6(sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func button7(sender: UIButton) {
        checkAnswer(sender)
    }
    
    var gameType = [String]()
    var currentGame = [String]()
    var currentGameNames = [String]()
    var solution = [String: AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Guess the Flag"
        
        newRound()
        setButtons()
    }
    
    func setButtons() {
        for button in gameButtons {
            button.hidden = true
            button.enabled = false
        }
        
        for i in 0 ..< Level.difficulty.rawValue {
            gameButtons[i].hidden = false
            gameButtons[i].enabled = true
            gameButtons[i].setTitle(currentGameNames[i], forState: .Normal)
        }
    }
    
    func newRound() {
        currentGame = [String]()
        currentGameNames = [String]()
        
        let countries = gameType
//        let countries = Countries.allColumns["abbreviation"]!
        var randomFlags = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries)
        
        for i in 0 ..< Level.difficulty.rawValue {
            currentGame.append(randomFlags[i] as! String)
        }
        
        let solutionFlag = GKRandomSource.sharedRandom().nextIntWithUpperBound(Level.difficulty.rawValue)
        solution["countryAbb"] = currentGame[solutionFlag]
        solution["countryIndex"] = solutionFlag
        
        if currentGame[solutionFlag].containsString("US") {
            solution["name"] = Countries.usStates[currentGame[solutionFlag]]
            
            for abbreviation in currentGame {
                currentGameNames.append(Countries.usStates[abbreviation]!)
            }
        } else {
            solution["name"] = Countries.allRows[currentGame[solutionFlag]]!["name"]
            
            for abbreviation in currentGame {
                currentGameNames.append(Countries.allRows[abbreviation]!["name"]!)
            }
        }
        
        let path = NSBundle.mainBundle().pathForResource(currentGame[solutionFlag], ofType: "png")!
        let flag = UIImage(contentsOfFile: path)
        flagImage.image = flag
        solution["flagImage"] = flag
    }
    
    func checkAnswer(sender: UIButton) {
        if sender.titleLabel!.text == solution["name"] as? String {
            correctGuess()
        } else {
            wrongGuess()
        }
    }
    
    func correctGuess() {
        self.title = solution["name"] as? String
        
        let ac = UIAlertController(title: "Correct Answer", message: nil, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: nextRound))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func wrongGuess() {
        self.title = solution["name"] as? String
        
        let answer = (solution["name"] as! String)
        
        let ac = UIAlertController(title: "Wrong Answer", message: "The correct answer was \(answer).", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: nextRound))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func nextRound(action: UIAlertAction!) {
        newRound()
        setButtons()
        self.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
