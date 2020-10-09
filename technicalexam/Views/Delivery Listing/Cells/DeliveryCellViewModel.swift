//
//  DeliveryTableViewCellViewModel.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

struct DeliveryCellViewModel {
    private let delivery: Delivery
    
    init(delivery: Delivery) {
        self.delivery = delivery
    }
    
    var title: String {
        self.delivery.id ?? ""
    }
    
    var description: String {
        self.delivery.remarks ?? ""
    }
    
    var price: String {
        self.delivery.deliveryFee ?? "" + (self.delivery.surcharge ?? "")
    }
    
    var image: String {
        self.delivery.goodsPicture ?? ""
    }
}
