//
//  ViewController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/2/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

struct Level {
    static var difficulty = Difficulty.Medium
}

struct Countries {
    static var allColumns = [String: [String]]()
    static var allRows = [String: [String: String]]()
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
                Countries.allRows[abb] = csv.rows[row]
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

