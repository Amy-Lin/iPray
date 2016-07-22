//
//  prayItemCell.swift
//  iPray
//
//  Created by Amy Lin on 10/07/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import UIKit

class prayerRequestItemCell: UITableViewCell {

    @IBOutlet weak var prayerRequestItemName: UILabel!
    
    
    
    var prayerRequestItem: PrayerRequestItem!{

        
        didSet{
            prayerRequestItemName.text = prayerRequestItem.prayerRequestName
        }
    }
}
