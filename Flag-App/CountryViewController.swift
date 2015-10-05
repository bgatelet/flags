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
    
    var name: String?
    var flag: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryName.text = Countries.allRows[name!]!["full name"]
        countryFlag.image = flag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
