//
//  RealmRepresentable.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType

    var uid: String {get}

    func asRealm() -> RealmType
}
