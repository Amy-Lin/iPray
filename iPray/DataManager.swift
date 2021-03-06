//
//  DataManager.swift
//  iPray
//
//  Created by Amy Lin on 24/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import RealmSwift

class DataManager {
    static let sharedInstance = DataManager()
    let realm = try! Realm()
    var prayerRequestItems : [PrayerRequestItem] = [PrayerRequestItem]()
    
    func selectOneItem(id: String) -> PrayerRequestItem {
        for item in prayerRequestItems {
            if(item.prayerRequestId == id) {
                return item
            }
        }
        return PrayerRequestItem()
    }
    
    func getAllItemsFromDb() -> [PrayerRequestItem]{
        let items = Array(realm.objects(PrayerRequestItem.self).sorted("prayerRequestTime", ascending: false))
        prayerRequestItems = items
        return items
    }
    
    func appendOneItem(newItem: PrayerRequestItem){
        prayerRequestItems.append(newItem)        
        try! realm.write {
            realm.add(newItem)
        }
    }
    
    func updateOneItem(newItem: PrayerRequestItem) {
        for (index, item) in prayerRequestItems.enumerate() {
            if (item.prayerRequestId == newItem.prayerRequestId){
                prayerRequestItems.removeAtIndex(index)
                prayerRequestItems.insert(newItem, atIndex: index)
                try! realm.write {
                    realm.add(newItem, update: true)
                }
            }
        }
    }
    
    func deleteOneItem(indexOfItemToBeDelete index: Int){
        for (i, item) in prayerRequestItems.enumerate(){
            if (i == index){
                prayerRequestItems.removeAtIndex(i)
                try! realm.write {
                    realm.delete(item)
                }
            }
        }
    }
    
    func setAnswerFlagForOneItem(indexOfItemToBeFlagged index: Int) {
        realm.beginWrite()
        for (i, item) in prayerRequestItems.enumerate(){
            if (i == index){
                if (item.prayerRequestAnswered == true) {
                    item.prayerRequestAnswered = false
                } else {
                    item.prayerRequestAnswered = true
                }
            }
        }
        try! realm.commitWrite()
    }
}
