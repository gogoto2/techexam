//
//  DateHelper.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

extension String {

    func toDateFormatted() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "hh:mm a"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        guard let date = dateFormatterGet.date(from: self) else { return "N/A" }
        return "\(dateFormatterPrint.string(from: date)) at \(dateFormatterTime.string(from: date))"
    }
}
