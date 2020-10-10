//
//  RealmDelivery.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RealmDelivery: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var slug: String = ""
    @objc dynamic var statusOptionId: Int = 0
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var remarks: String = ""
    @objc dynamic var pickupTime: String = ""
    @objc dynamic var goodsPicture: String = ""
    @objc dynamic var deliveryFee: String = ""
    @objc dynamic var surcharge: String = ""
    @objc dynamic var route: RealmRoute?
    @objc dynamic var sender: RealmSender?
    @objc dynamic var favorite: Bool = false
    var parentPage = LinkingObjects(fromType: RealmDeliveryPage.self, property: "deliveries")
}

extension RealmDelivery: DomainConvertibleType {
    func asDomain() -> Delivery {
        return Delivery(id: id,
                        remarks: remarks,
                        pickupTime: pickupTime,
                        goodsPicture: goodsPicture,
                        deliveryFee: deliveryFee,
                        surcharge: surcharge,
                        route: route?.asDomain(),
                        sender: sender?.asDomain(),
                        favorite: favorite,
                        page: parentPage)
    }
}

extension Delivery: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RealmDelivery {
        return RealmDelivery.build { object in
            object.id = id ?? ""
            object.remarks = remarks ?? ""
            object.pickupTime = pickupTime ?? ""
            object.goodsPicture = goodsPicture ?? ""
            object.deliveryFee = deliveryFee ?? ""
            object.surcharge = surcharge ?? ""
            object.route = route?.asRealm()
            object.sender = sender?.asRealm()
            object.favorite = favorite ?? false
        }
    }
}
