//
//  Utils.swift
//  iPray
//
//  Created by Amy Lin on 12/08/2016.
//  Copyright © 2016 Amy Lin. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
