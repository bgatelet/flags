//
//  CountryViewController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryContinent: UILabel!
    @IBOutlet weak var countryRatio: UILabel!
    
    var name: String!
    var flag: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if name != "???" {
            if name.containsString("US") {
                countryName.text = Countries.usStates[name]
                countryContinent.text = "North America"
            } else {
                countryName.text = Countries.allRows[name]!["full name"]
                
                let continent = Countries.allRows[name]!["continent"]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                switch continent {
                case "EU":
                    countryContinent.text = "Europe"
                case "AS":
                    countryContinent.text = "Asia"
                case "AF":
                    countryContinent.text = "Africa"
                case "OC":
                    countryContinent.text = "Ocenia"
                case "NA":
                    countryContinent.text = "North America"
                case "SA":
                    countryContinent.text = "South America"
                case "AN":
                    countryContinent.text = "Antarctica"
                default:
                    break
                }
            }
            
            if name != "???" { countryFlag.image = flag }

            
            if let ratioSeen = Ratios.seen[name] {
                if let ratioCorrect =  Ratios.correct[name] {
                    
                    // Conversion to Double must be made explicit
                    let ratio = round((Double(ratioCorrect) / Double(ratioSeen)) * 100.0 * 4.0) / 4.0
                    countryRatio.text = "Guessed correctly: \(ratio)%"
                }
            } else {
                countryRatio.text = "Not yet seen."
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
