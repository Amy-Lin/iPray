//
//  PrayItem.swift
//  iPray
//
//  Created by Amy Lin on 10/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import RealmSwift

class PrayerRequestItem: Object {
    
    dynamic var prayerRequestId: String = NSUUID().UUIDString
    dynamic var prayerRequestName: String = ""
    dynamic var prayerRequester: String = ""
    dynamic var prayerRequestTime: NSDate = NSDate()
    dynamic var prayerRequestAnswered: Bool = false
    
    convenience init(name: String, requester: String, time: NSDate, answered: Bool) {
        self.init()
        self.prayerRequestId = NSUUID().UUIDString
        self.prayerRequestName = name
        self.prayerRequester = requester
        self.prayerRequestTime = time
        self.prayerRequestAnswered = answered
    }
    
    override static func primaryKey() -> String {
        return "prayerRequestId"
    }

}
