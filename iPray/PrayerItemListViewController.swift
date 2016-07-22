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

    var prayerItems: [PrayerRequestItem] = prayerRequestItemsData
//    let realm = try! Realm()
//    lazy var categories: Results<PrayerRequestItem> = { self.realm.objects(PrayerRequestItem) }()
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrayCell", forIndexPath: indexPath) as! prayerRequestItemCell
        let prayerItem = prayerItems[indexPath.row] as PrayerRequestItem
        cell.prayerRequestItem = prayerItem
//        cell.textLabel?.text = prayerItem.prayerRequestName
//        cell.detailTextLabel?.text = prayerItem.prayerRequester
        return cell
    }
 
}
