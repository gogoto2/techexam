//
//  RealmFavorites.swift
//  technicalexam
//
//  Created by iOS on 10/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmFavorite: Object {
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var uuid: String = ""
    
    var deliveries = List<RealmDelivery>()
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
}

extension RealmFavorite: DomainConvertibleType {
    func asDomain() -> Favorite {
        return Favorite(uuid: uuid,
                        isFavorite: isFavorite,
                        deliveries: deliveries.mapToDomain())
        
    }
}

extension Favorite: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RealmFavorite {
        return RealmFavorite.build { object in
            object.uuid = uuid
            object.isFavorite = isFavorite
            object.deliveries = deliveries.mapToList()
        }
    }
}
