//
//  RealmRepository.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import ObjectMapper

struct Route {
	var start: String?
	var end: String?
}


extension Route: Mappable {
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        start <- map["start"]
        end <- map["end"]
    }
}
