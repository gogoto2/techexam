//
//  FeatureAssemblu.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Swinject

class FeatureAssembly: Assembly {
    func assemble(container: Container) {
        assembleListing(container)
        assembleDetails(container)
    }
}

// MARK: - Delivery Listing

extension FeatureAssembly {
    func assembleListing(_ container: Container) {
        container.autoregister(DeliveryListingViewModel.self,
                               initializer: DeliveryListingViewModel.init)
        container.autoregister(DeliveryListingViewController.self,
                               initializer: DeliveryListingViewController.init)
    }
}

// MARK: - Delivery Details

extension FeatureAssembly {
    func assembleDetails(_ container: Container) {
        container.autoregister(DeliveryDetailsViewModel.self,
                               initializer: DeliveryDetailsViewModel.init)
        container.autoregister(DeliveryDetailsViewController.self,
                               initializer: DeliveryDetailsViewController.init)
        
        container.register(DeliveryDetailsViewController.self) { (resolver: Resolver, arg1: Delivery) in
            let viewModel = resolver.resolve(DeliveryDetailsViewModel.self)!
            return DeliveryDetailsViewController.init(deliveryDetailsViewModel: viewModel, delivery: arg1)
        }
    }
}
