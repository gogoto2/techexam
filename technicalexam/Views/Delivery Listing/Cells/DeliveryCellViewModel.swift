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
        self.delivery.pickupTime?
            .toDateFormatted() ?? ""
    }
    
    var location: String {
        "From: \(self.delivery.route?.start ?? "")\nTo: \(self.delivery.route?.end ?? "")"
    }
    
    var price: String {
        guard let deliverySurcharge = self.delivery.surcharge,
              let deliveryFee = self.delivery.deliveryFee
        else { return "" }
        return "Price: \(deliveryFee.addFormattedCurrency(with: deliverySurcharge, locale: Locale.current))"
    }
    
    var favorite: Bool {
        return delivery.favorite?.first?.isFavorite ?? false
        print("is favorite na? \(delivery.favorite?.first?.isFavorite)")
    }
    
    var image: String {
        self.delivery.goodsPicture ?? ""
    }
}
