//
//  RealmRepository.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import ObjectMapper

struct Sender {
	var phone: String?
	var name: String?
	var email: String?
}

extension Sender: Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        phone <- map["phone"]
        name <- map["name"]
        email <- map["email"]
    }
}
