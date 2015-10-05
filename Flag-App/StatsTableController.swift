//
//  StatsTableController.swift
//  Flag-App
//
//  Created by Brice Gatelet on 10/3/15.
//  Copyright © 2015 Brice Gatelet. All rights reserved.
//

import UIKit

class StatsTableController: UITableViewController {

    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for abbreviation in Countries.orderedKeys {
            items.append(abbreviation)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // find the image for this cell, and load its thumbnail
        let currentImage = items[indexPath.row]
        let imageRootName = currentImage.stringByReplacingOccurrencesOfString(".png", withString: "")
        
        let path = NSBundle.mainBundle().pathForResource(imageRootName, ofType: "png")!
        cell.imageView!.image = UIImage(contentsOfFile: path)
        cell.textLabel!.text = Countries.allRows[imageRootName]!["name"]
        
        return cell

    }
    
    var imageName: String!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Country" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let currentImage = items[indexPath.row]
                imageName = currentImage.stringByReplacingOccurrencesOfString(".png", withString: "")
                
                let path = NSBundle.mainBundle().pathForResource(imageName, ofType: "png")!
                let flag = UIImage(contentsOfFile: path)
                
                let countryViewController = segue.destinationViewController as! CountryViewController
                countryViewController.name = imageName
                countryViewController.flag = flag
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
