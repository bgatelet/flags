//
//  ViewController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/2/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

enum Difficulty: Int {
    case Easy = 2
    case Medium = 4
    case Hard = 6
    case Extreme = 8
}

struct Level {
    static var difficulty = Difficulty.Medium
    
    static func save() {
        let savedDifficulty = NSKeyedArchiver.archivedDataWithRootObject(difficulty.rawValue)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(savedDifficulty, forKey: "difficulty")
    }
    
    static func setDiffulty (level: Int64) {
        switch level {
        case 2:
            difficulty = Difficulty.Easy
        case 4:
            difficulty = Difficulty.Medium
        case 6:
            difficulty = Difficulty.Hard
        case 8:
            difficulty = Difficulty.Extreme
        default:
            difficulty = Difficulty.Medium
        }
    }
}

struct Countries {
    static var allColumns = [String: [String]]()
    static var allRows = [String: [String: String]]()
    static var orderedKeys = [String]()
    static var euKeys = [String]()
    static var asKeys = [String]()
    static var afKeys = [String]()
    static var ocKeys = [String]()
    static var naKeys = [String]()
    static var saKeys = [String]()
    
    static var usStates = [String: String]()
    static var usKeys = [String]()
    
    static var allKeys: Int!
    
    static var unlocked = false
    
    static func save() {
        let lock = NSKeyedArchiver.archivedDataWithRootObject(unlocked)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(lock, forKey: "ratioLock")
    }
}

struct Ratios {
    static var seen = [String: Int]()
    static var correct = [String: Int]()
    static var ratioAll = [String: Double]()
    static var totalFlagsSeen: Double!
    
    static var underTwo = [String]()
    static var underFifty = [String]()
    static var underSeven = [String]()
    
    static func save() {
        let savedData = NSKeyedArchiver.archivedDataWithRootObject(seen)
        let otherSavedData = NSKeyedArchiver.archivedDataWithRootObject(correct)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(savedData, forKey: "seen")
        defaults.setObject(otherSavedData, forKey: "correct")
    }
    
    static func updateTotal() {
        Countries.allKeys = Countries.orderedKeys.count + Countries.usKeys.count
        Ratios.totalFlagsSeen = round((Double(Ratios.seen.count) / Double(Countries.allKeys) * 100.0) * 4.0) / 4.0
        
        underTwo = [String]()
        underFifty = [String]()
        underSeven = [String]()
        
        for (key, value) in Ratios.seen {
            if let ratioCorrect =  Ratios.correct[key] {
                
                Ratios.ratioAll[key] = round((Double(ratioCorrect) / Double(value)) * 100.0 * 4.0) / 4.0
                
                let ratioTemp = Ratios.ratioAll[key]
                if ratioTemp < 25.0 {
                    Ratios.underTwo.append(key)
                } else if ratioTemp < 50.0 {
                    Ratios.underFifty.append(key)
                } else if ratioTemp < 75.0 {
                    Ratios.underSeven.append(key)
                }
            }
        }
        
        if Ratios.ratioAll.count == Countries.allKeys {
            Countries.unlocked = true
            Countries.save()
        }
    }
    
    static func analyzeArea(keys: [String]) -> Int {
        var counter = 0
        
        for key in keys {
            if Ratios.seen[key] != nil {
                ++counter
            }
        }
        
        return counter
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let seen = defaults.objectForKey("seen") as? NSData {
            Ratios.seen = NSKeyedUnarchiver.unarchiveObjectWithData(seen) as! [String: Int]
        }
        if let correct = defaults.objectForKey("correct") as? NSData {
            Ratios.correct = NSKeyedUnarchiver.unarchiveObjectWithData(correct) as! [String: Int]
        }
        if let difficulty = defaults.objectForKey("difficulty") as? NSData {
            let data = NSKeyedUnarchiver.unarchiveObjectWithData(difficulty)
            Level.setDiffulty((data?.longLongValue)!)
        }
        if let lock = defaults.objectForKey("ratioLock") as? NSData {
            Countries.unlocked = NSKeyedUnarchiver.unarchiveObjectWithData(lock) as! Bool
        }
        
        let path = NSBundle.mainBundle().pathForResource("countries", ofType: "csv")!
        
        let error: NSErrorPointer = nil
        if let csv = try! CSV(contentsOfFile: path, error: error) {
            for header in csv.headers {
                Countries.allColumns[header] = csv.columns[header]!
            }
            
            for row in 0 ..< csv.rows.count {
                let abb = csv.rows[row]["abbreviation"]!
                Countries.orderedKeys.append(abb)
                Countries.allRows[abb] = csv.rows[row]
                
                let continent = csv.rows[row]["continent"]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                switch continent {
                case "EU":
                    Countries.euKeys.append(abb)
                case "AS":
                    Countries.asKeys.append(abb)
                case "AF":
                    Countries.afKeys.append(abb)
                case "OC":
                    Countries.ocKeys.append(abb)
                case "NA":
                    Countries.naKeys.append(abb)
                case "SA":
                    Countries.saKeys.append(abb)
                default:
                    break
                }
            }
        }
        
        let pathUS = NSBundle.mainBundle().pathForResource("USstates", ofType: "csv")!
        
        let errorUS: NSErrorPointer = nil
        if let csvUS = try! CSV(contentsOfFile: pathUS, error: errorUS) {
            
            for row in 0 ..< csvUS.rows.count {
                let abb = csvUS.rows[row]["abbreviation"]!
                Countries.usKeys.append(abb)
                Countries.usStates[abb] = csvUS.rows[row]["name"]!
            }
        }
        
        Ratios.updateTotal()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        performSegueWithIdentifier("Main", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

