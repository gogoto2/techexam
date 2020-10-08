//
//  Array+Ext.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift

extension Array where Iterator.Element: RealmRepresentable {
    func mapToList<T>() -> List<T> {
        let listArray = compactMap { $0.asRealm() as? T }
        let listItem = List<T>()
        listItem.append(objectsIn: listArray)
        return listItem
    }
}
