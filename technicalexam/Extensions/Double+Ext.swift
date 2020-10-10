//
//  Double+Ext.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

extension Double {
   static func timeStampFromDate(date: NSDate) -> Double {
        return date.timeIntervalSince1970
    }
}
