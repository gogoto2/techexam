//
//  FeatureAssemblu.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Swinject

class DeliveryListingAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(DeliveryListingViewModel.self,
                               initializer: DeliveryListingViewModel.init)
        container.autoregister(DeliveryListingViewController.self,
                               initializer: DeliveryListingViewController.init)
    }
}
