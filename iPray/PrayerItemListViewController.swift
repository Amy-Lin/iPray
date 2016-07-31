//
//  PrayItemListViewController.swift
//  iPray
//
//  Created by Amy Lin on 2/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit

class PrayerItemListViewController: UITableViewController {

    var prayerItems: [PrayerRequestItem] = DataManager.sharedInstance.prayerRequestItems
    var selectedPrayerItemId: String = ""
   
    override func viewDidAppear(animated: Bool) {
        prayerItems = DataManager.sharedInstance.getAllItemsFromDb()
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.prayerRequestItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrayCell", forIndexPath: indexPath) as! prayerRequestItemCell
        let prayerItem =  DataManager.sharedInstance.prayerRequestItems[indexPath.row] as PrayerRequestItem
        cell.prayerRequestItem = prayerItem
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .Destructive, title: "Delete") { (action, indexPath) in
            DataManager.sharedInstance.deleteOneItem(indexOfItemToBeDelete: indexPath.row)
            self.tableView.reloadData()
        }
        
        let answered = UITableViewRowAction(style: .Normal, title: "Answered") { (action, indexPath) in
            DataManager.sharedInstance.setAnswerFlagForOneItem(indexOfItemToBeFlagged: indexPath.row)
            self.tableView.reloadData()
        }
        answered.backgroundColor = UIColor.darkGrayColor()
        
        return [delete, answered]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPrayerItemId = DataManager.sharedInstance.prayerRequestItems[indexPath.row].prayerRequestId      
        self.performSegueWithIdentifier("fromListToItem", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "fromListToItem" ) {
            let prayerRequestViewController = segue.destinationViewController as! PrayerRequestViewController
            prayerRequestViewController.prayerRequestUuid = self.selectedPrayerItemId
        }
    }
 
}
