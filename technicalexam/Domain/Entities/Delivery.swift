//
//  RealmRepository.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

struct Delivery {
	var id: String?
	var remarks: String?
	var pickupTime: String?
	var goodsPicture: String?
	var deliveryFee: String?
	var surcharge: String?
	var route: Route?
	var sender: Sender?
    
    // Tempo fix for deliveries assoc. page,
    // As part of the code convention, we are not supposed to edit pojo file
    var uuid: String?
    var favorite: Bool?
    var page: LinkingObjects<RealmDeliveryPage>?
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
