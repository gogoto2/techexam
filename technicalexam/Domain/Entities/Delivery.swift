//
//  RealmRepository.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import ObjectMapper

struct Delivery {
	var id: String?
	var remarks: String?
	var pickupTime: String?
	var goodsPicture: String?
	var deliveryFee: String?
	var surcharge: String?
	var route: Route?
	var sender: Sender?
}

extension Delivery: Mappable {
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        id <- map["id"]
        remarks <- map["remarks"]
        pickupTime <- map["pickupTime"]
        goodsPicture <- map["goodsPicture"]
        deliveryFee <- map["deliveryFee"]
        surcharge <- map["surcharge"]
        route <- map["route"]
        sender <- map["sender"]
    }
}
