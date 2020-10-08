//
//  BaseService.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Moya

protocol BaseService: TargetType { }

extension BaseService {
    var headers: [String: String]? {
        return [
            "Content-type": "application/json",
        ]
    }
}
