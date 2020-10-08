//
//  UseCaseAssembly.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Swinject

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(DefaultFetchDeliveryUseCase.self,
                               initializer: DefaultFetchDeliveryUseCase.init)
    }
}
