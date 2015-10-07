//
//  GameController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import GameKit
import UIKit

class GameController: UICollectionViewController {
    
    var gameType = [String]()
    var currentGame = [String]()
    var solution = [String: AnyObject]()
    var played = [String]()
    var rounds = 0
    var correct = 0
    var count = 0
    var message: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = gameType.count
        
        newRound(nil)
    }
    
    func newRound(action: UIAlertAction!) {
        // The last ones not seen get recycled and have a higher chance of being seen next time.
        if gameType.count < Level.difficulty.rawValue {
            gameType += played
            played = [String]()
        }
        
        currentGame = [String]()
        let randomFlagsTemp = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(gameType)
        var randomFlags = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(randomFlagsTemp)
        
        for i in 0 ..< Level.difficulty.rawValue {
            currentGame.append(randomFlags[i] as! String)
        }
        
        let solutionFlag = GKRandomSource.sharedRandom().nextIntWithUpperBound(Level.difficulty.rawValue)
        solution["countryAbb"] = currentGame[solutionFlag]
        solution["countryIndex"] = solutionFlag
        
        if currentGame[solutionFlag].containsString("US") {
            self.title = Countries.usStates[currentGame[solutionFlag]]
        } else {
            self.title = Countries.allRows[currentGame[solutionFlag]]!["name"]
        }
        
        ++rounds
        self.collectionView!.reloadData()
    }
    
    func setMessage() {
        message = "Correct: \(round(Double(correct) / Double(rounds) * 100.0) * 4.0 / 4.0)%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Level.difficulty.rawValue
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Flag", forIndexPath: indexPath)
        
        let path = NSBundle.mainBundle().pathForResource(currentGame[indexPath.item], ofType: "png")!
        let flag = UIImage(contentsOfFile: path)
        
        solution["flagImage"] = flag
        
        if let imageView = cell.viewWithTag(1000) as? UIImageView {
            imageView.image = flag
        }
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == solution["countryIndex"] as! Int {
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
            ac.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: newRound))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let abbreviation = solution["countryAbb"] as! String
            if Ratios.seen[abbreviation] != nil {
                Ratios.seen[abbreviation]! += 1
            } else {
                Ratios.seen[abbreviation] = 1
                Ratios.correct[abbreviation] = 0
            }
            
            Ratios.save()
            setMessage()
            
            let flagIndex = (solution["countryIndex"] as! Int) + 1
            var choice: String
            
            if currentGame[indexPath.item].containsString("US") {
                choice = Countries.usStates[currentGame[indexPath.item]]!
            } else {
                choice = Countries.allRows[currentGame[indexPath.item]]!["name"]!
            }
            
            let ac = UIAlertController(title: "Wrong Answer", message: "You picked the flag of \(choice). The correct answer was flag number \(flagIndex).\n\(message)", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Next Round", style: .Default, handler: newRound))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
}
