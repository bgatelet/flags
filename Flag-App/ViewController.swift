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
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        performSegueWithIdentifier("Main", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

