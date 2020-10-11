//
//  DefaultFavoritesDeliveryUseCase.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Moya

protocol ToggleFavoriteUseCase {
    func execute(requestValue: ToggleFavoriteUseCaseReqValue) -> Observable<Bool>
}

final class DefaultToggleFavoriteUseCase: ToggleFavoriteUseCase {
    private var deliveryRepository: RealmRepository<Delivery>
    private var disposeBag = DisposeBag()

    init(deliveryRepository: RealmRepository<Delivery>) {
        self.deliveryRepository = deliveryRepository
    }

    func execute(requestValue: ToggleFavoriteUseCaseReqValue) -> Observable<Bool> {
        return self.deliveryRepository.byPrimaryId(primaryKey: requestValue.deliveryUUID)
            .filterNil()
            .flatMapLatest { delivery -> Observable<Bool> in
                guard let favorite = delivery.favorite else { return Observable.just(false) }
                var delivery = delivery
                delivery.favorite = !favorite
                self.deliveryRepository.save(entity: delivery)
                return Observable.just(!favorite)
            }
    }
}

struct ToggleFavoriteUseCaseReqValue {
    let deliveryUUID: String
}
