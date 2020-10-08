//
//  RealmRoute.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class RealmRoute: Object {
    @objc dynamic var start: String = ""
    @objc dynamic var end: String = ""
}

extension RealmRoute: DomainConvertibleType {
    func asDomain() -> Route {
        return Route(start: start, end: end)
    }
}

extension Route: RealmRepresentable {
    internal var uid: String {
        return ""
    }
    
    func asRealm() -> RealmRoute {
        return RealmRoute.build { object in
            object.start = start ?? ""
            object.end = end ?? ""
        }
    }
}
