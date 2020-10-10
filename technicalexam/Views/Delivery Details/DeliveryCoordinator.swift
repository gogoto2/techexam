//
//  DeliveryCoordinator.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class DeliveryDetailsCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController
    private var delivery: Delivery
    
    init(navigationController: UINavigationController, delivery: Delivery) {
        self.navigationController = navigationController
        self.delivery = delivery
        super.init()
    }
    
    override func start() {
        let deliveryDetailsViewController = Assembler.shared
            .resolver
            .resolve(DeliveryDetailsViewController.self, argument: self.delivery)!
        self.navigationController.pushViewController(deliveryDetailsViewController, animated: true)
    }
}
