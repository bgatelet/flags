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
    var keysCopy = [String]()
    var currentGame = [String]()
    var currentGameNames = [String]()
    var solution = [String: AnyObject]()
    var played = [String]()
    var rounds = 0
    var correct = 0
    var count = 0
    var seenCount = 0
    var message: String!
    var isRatio = false
    var ratioType: Int!
    var finishCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Guess the Flag"
        
        keysCopy = gameType
        count = gameType.count
        
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
        
        // The last ones not seen get recycled and have a higher chance of being seen next time.
        if gameType.count < Level.difficulty.rawValue {
            finishCounter = 0
            
            for key in keysCopy {
                let ratio = round(Double(Ratios.correct[key]!) / Double(Ratios.seen[key]!) * 100.0 * 4.0) / 4.0
                if ratio < Double(ratioType) {
                    ++finishCounter
                }
            }
            
            if finishCounter < Level.difficulty.rawValue {
                let ac = UIAlertController(title: "Finished!", message: "There are not enough flags left to play this mode.", preferredStyle: .Alert)
                ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: popBack))
                presentViewController(ac, animated: true, completion: nil)
            }
            
            gameType = [String]()
            gameType = keysCopy
            played = [String]()
        }
        
        let randomFlagsTemp = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(gameType)
        var randomFlags = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(randomFlagsTemp)
        
        for i in 0 ..< Level.difficulty.rawValue {
            currentGame.append(randomFlags[i] as! String)
        }
        
        let solutionFlag = GKRandomSource.sharedRandom().nextIntWithUpperBound(Level.difficulty.rawValue)
        solution["countryAbb"] = currentGame[solutionFlag]
        solution["countryIndex"] = solutionFlag
        
        if currentGame[solutionFlag].containsString("US-") {
            solution["name"] = Countries.usStates[currentGame[solutionFlag]]
            
            for abbreviation in currentGame {
                if abbreviation.containsString("US-") {
                    currentGameNames.append(Countries.usStates[abbreviation]!)
                } else {
                    currentGameNames.append(Countries.allRows[abbreviation]!["name"]!)
                }
            }
        } else {
            solution["name"] = Countries.allRows[currentGame[solutionFlag]]!["name"]
            
            for abbreviation in currentGame {
                if abbreviation.containsString("US-") {
                    currentGameNames.append(Countries.usStates[abbreviation]!)
                } else {
                    currentGameNames.append(Countries.allRows[abbreviation]!["name"]!)
                }
            }
        }
        
        let path = NSBundle.mainBundle().pathForResource(currentGame[solutionFlag], ofType: "png")!
        let flag = UIImage(contentsOfFile: path)
        flagImage.image = flag
        solution["flagImage"] = flag
        
        ++rounds
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
        
        let abbreviation = solution["countryAbb"] as! String
        if Ratios.seen[abbreviation] != nil {
            Ratios.seen[abbreviation]! += 1
            Ratios.correct[abbreviation]! += 1
        } else {
            Ratios.seen[abbreviation] = 1
            Ratios.correct[abbreviation] = 1
        }
        
        Ratios.save()
        
        played.append(solution["countryAbb"] as! String)
        gameType = Array(Set(gameType).subtract(Set(played)))
        
        ++correct
        setMessage()
        
        let ac = UIAlertController(title: "Correct Answer", message: message, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: nextRound))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func wrongGuess() {
        self.title = solution["name"] as? String
        
        let abbreviation = solution["countryAbb"] as! String
        if Ratios.seen[abbreviation] != nil {
            Ratios.seen[abbreviation]! += 1
        } else {
            Ratios.seen[abbreviation] = 1
            Ratios.correct[abbreviation] = 0
        }
        
        Ratios.save()
        setMessage()
        
        let answer = (solution["name"] as! String)
        
        let ac = UIAlertController(title: "Wrong Answer", message: "The correct answer was \(answer).\n\(message)", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: nextRound))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func nextRound(action: UIAlertAction!) {
        newRound()
        setButtons()
        self.title = ""
    }
    
    func setMessage() {
        
        if isRatio == false {
            seenCount = Ratios.analyzeArea(keysCopy)
            message = "Correct: \(round(Double(correct) / Double(rounds) * 100.0) * 4.0 / 4.0)%\nSeen: \(seenCount)/\(keysCopy.count)"
        } else {
            let currentFlag = solution["countryAbb"] as! String
            let ratio = round(Double(Ratios.correct[currentFlag]!) / Double(Ratios.seen[currentFlag]!) * 100.0 * 4.0) / 4.0
            message = "Guessed correctly: \(ratio)%"
        }
    }
    
    func popBack(sender: UIAlertAction!) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
