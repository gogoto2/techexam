//
//  RealmDeliveryPage.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RealmDeliveryPage: Object {
    @objc dynamic var page: Int = 0
    var deliveries = List<RealmDelivery>()

    override class func primaryKey() -> String? {
        return "page"
    }
}

extension RealmDeliveryPage: DomainConvertibleType {
    func asDomain() -> DeliveryPage {
        return DeliveryPage(deliveries: deliveries.mapToDomain(),
                            page: page)
        
    }
}

extension DeliveryPage: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RealmDeliveryPage {
        return RealmDeliveryPage.build { object in
            object.page = page
            object.deliveries = deliveries.mapToList() ?? List<RealmDelivery>()
        }
    }
}
