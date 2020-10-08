//
//  DomainConvertable.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Foundation
protocol DomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}
