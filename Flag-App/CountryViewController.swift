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
    
    var name: String?
    var flag: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryName.text = Countries.allRows[name!]!["full name"]
        countryFlag.image = flag
        
        let continent = Countries.allRows[name!]!["continent"]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
