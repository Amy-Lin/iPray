//
//  DataManager.swift
//  iPray
//
//  Created by Amy Lin on 24/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//


class DataManager {
    var prayerRequestItems : [PrayerRequestItem] = [PrayerRequestItem]()
    static let sharedInstance = DataManager()
    
    enum dataError : ErrorType {
        case DataNotFound
        case DataUnknowError
    }
    
    func selectOneItem(id: String) -> PrayerRequestItem {
        for item in prayerRequestItems {
            if(item.prayerRequestId == id) {
                return item
            }
        }
        return PrayerRequestItem()
    }
    
    func updateOneItem(newItem: PrayerRequestItem) {
        for (index, item) in prayerRequestItems.enumerate() {
            if (item.prayerRequestId == newItem.prayerRequestId){
                prayerRequestItems.removeAtIndex(index)
                prayerRequestItems.insert(newItem, atIndex: index)
            }
        }
    }
}
