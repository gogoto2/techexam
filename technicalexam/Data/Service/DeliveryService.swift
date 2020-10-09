//
//  DeliveryService.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Moya

enum DeliveryService {
    case getListing(page: Int, offset: Int)
}

extension DeliveryService: BaseService {
    var baseURL: URL {
        return URL(string: endpoint)!
    }
    
    var path: String {
        switch self {
        case .getListing:  return "/deliveries"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getListing:  return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .getListing(page, offset):
            return .requestParameters(
                parameters: [
                    "limit": page,
                    "offset": offset
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
}
