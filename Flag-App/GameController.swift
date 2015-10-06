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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound(nil)
    }
    
    func newRound(action: UIAlertAction!) {
        currentGame = [String]()
        let countries = gameType
        var randomFlags = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries)
        
        for i in 0 ..< Level.difficulty.rawValue {
            currentGame.append(randomFlags[i] as! String)
        }
        
        let solutionFlag = GKRandomSource.sharedRandom().nextIntWithUpperBound(Level.difficulty.rawValue)
        solution["countryAbb"] = currentGame[solutionFlag]
        solution["countryIndex"] = solutionFlag
        
        self.title = Countries.allRows[currentGame[solutionFlag]]!["name"]
        self.collectionView!.reloadData()
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
            let ac = UIAlertController(title: "Correct Answer", message: nil, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Replay", style: .Default, handler: newRound))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Wrong Answer", message: nil, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
}
