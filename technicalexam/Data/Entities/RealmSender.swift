//
//  RealmSender.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RealmSender: Object {
    @objc dynamic var phone: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""

    override class func primaryKey() -> String? {
        return "email"
    }
}

extension RealmSender: DomainConvertibleType {
    func asDomain() -> Sender {
        return Sender(phone: phone,
                      name: name,
                      email: email)
    }
}

extension Sender: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RealmSender {
        return RealmSender.build { object in
            object.phone = phone ?? ""
            object.name = name ?? ""
            object.email = email ?? ""
        }
    }
}
