//
//  NSDate+Ext.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

extension NSDate {
    /** Returns a NSDate instance from a time stamp */
    convenience init(timeStamp: Double) {
        self.init(timeIntervalSince1970: timeStamp)
    }
}
