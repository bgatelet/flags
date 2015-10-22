//
//  StatsTableController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class StatsTableController: UITableViewController {

    var items = [[String]]()
    var headers = ["(Seen \(Ratios.totalFlagsSeen)%)", "Countries", "US States"]
    var unlocked = true
    
    // For the segue
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stats"
        
        items.append([])
        items.append(Countries.orderedKeys)
        items.append(Countries.usKeys)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        // find the image for this cell, and load its thumbnail
        let currentImage = items[indexPath.section][indexPath.row]
        
        if Ratios.seen[currentImage] != nil {
            let imageRootName = currentImage.stringByReplacingOccurrencesOfString(".png", withString: "")
            
            cell.flagImage.image = UIImage(named: imageRootName)
            
            if imageRootName.containsString("US-") {
                cell.flagLabel.text = Countries.usStates[imageRootName]
            } else {
                cell.flagLabel.text = Countries.allRows[imageRootName]!["name"]
            }
        } else {
            cell.flagImage.image = nil
            cell.flagLabel.text = "???"
            unlocked = false
        }
        
        return cell

    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FlagView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let currentImage = items[indexPath.section][indexPath.row]
                
                if Ratios.seen[currentImage] != nil {
                    imageName = currentImage.stringByReplacingOccurrencesOfString(".png", withString: "")
                    
                    let flag = UIImage(named: imageName)
                    
                    let countryViewController = segue.destinationViewController as! CountryViewController
                    countryViewController.name = imageName
                    countryViewController.flag = flag
                } else {
                    let countryViewController = segue.destinationViewController as! CountryViewController
                    countryViewController.name = "???"
                    countryViewController.flag = nil
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
