//
//  File.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RxDataSources

struct DeliveryListingSection {
    var items: [Delivery]
}

extension DeliveryListingSection: SectionModelType {
    typealias Item = Delivery
    
    init(original: DeliveryListingSection, items: [Delivery]) {
        self = original
        self.items = items
    }
}
