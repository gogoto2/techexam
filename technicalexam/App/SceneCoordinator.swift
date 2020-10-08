//
//  SceneCoordinator.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class SceneCoordinator: BaseCoordinator {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        let deliveryListingViewController = Assembler.shared
            .resolver
            .resolve(DeliveryListingViewController.self)!
        window.rootViewController = deliveryListingViewController
        window.makeKeyAndVisible()
    }
}
