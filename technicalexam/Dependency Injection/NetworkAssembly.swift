//
//  NetworkAssembly.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Swinject
import Moya

class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkLoggerPlugin.self) { _ in
            NetworkLoggerPlugin.init()
        }
        
        container.register(MoyaProvider<DeliveryService>.self) { resolver in
            MoyaProvider<DeliveryService>(plugins: [resolver.resolve(NetworkLoggerPlugin.self)!])
        }
    }
}
