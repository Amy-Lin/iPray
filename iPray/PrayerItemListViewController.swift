//
//  PrayItemListViewController.swift
//  iPray
//
//  Created by Amy Lin on 2/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit
//import RealmSwift

class PrayerItemListViewController: UITableViewController {

    var prayerItems: [PrayerRequestItem] = DataManager.sharedInstance.PrayerRequestItems
//    let realm = try! Realm()
//    lazy var categories: Results<PrayerRequestItem> = { self.realm.objects(PrayerRequestItem) }()
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  DataManager.sharedInstance.PrayerRequestItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrayCell", forIndexPath: indexPath) as! prayerRequestItemCell
        let prayerItem =  DataManager.sharedInstance.PrayerRequestItems[indexPath.row] as PrayerRequestItem
        cell.prayerRequestItem = prayerItem
        return cell
    }
 
}
