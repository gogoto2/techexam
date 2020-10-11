//
//  RepositoryAssembly.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RealmSwift
import Swinject
import SwinjectAutoregistration

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Realm.Configuration.self) { _ in
            Realm.Configuration()
        }
        
        container.register(Realm.self) { resolver in
            try! Realm(configuration: resolver.resolve(Realm.Configuration.self)!)
        }
        
        container.autoregister(RealmRepository<DeliveryPage>.self,
                               initializer: RealmRepository<DeliveryPage>.init)
        
        container.autoregister(RealmRepository<Delivery>.self,
                               initializer: RealmRepository<Delivery>.init)
        
        container.autoregister(RealmRepository<Favorite>.self,
                               initializer: RealmRepository<Favorite>.init)
    }
}
