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
    func execute(requestValue: ToggleFavoriteUseCaseReqValue)
}

final class DefaultToggleFavoriteUseCase: ToggleFavoriteUseCase {
    private var deliveryRepository: RealmRepository<Delivery>
    private var disposeBag = DisposeBag()

    init(deliveryRepository: RealmRepository<Delivery>) {
        self.deliveryRepository = deliveryRepository
    }

    func execute(requestValue: ToggleFavoriteUseCaseReqValue) {
//        self.deliveryRepository.byPrimaryId(primaryKey: requestValue.deliveryUUID)
//        self.deliveryRepository
//            .byPrimaryId(primaryKey: requestValue.deliveryUUID)
//            .map {
//                var data = $0
//                data.favorite = !$0.favorite
//                return data
//            }.asObservable()
//        self.deliveryRepository.
//        let
//        Observable<[DeliveryPage]>.create { observer in
//            let serviceDisposable = self.deliveryService.rx
//                .request(.getListing(page: requestValue.limit, offset: requestValue.offset))
//                .mapArray(Delivery.self)
//                .subscribe(onSuccess: { deliveries in
//                    let deliveryPage = DeliveryPage(deliveries: deliveries,
//                                                    page: requestValue.offset)
//                    self.deliveryRepository.save(entity: deliveryPage)
//                }, onError: { error in
//                    observer.onError(error)
//                })
//
//            let query = NSPredicate(format: "page <= %i", requestValue.offset)
//            let repoDisposable = self.deliveryRepository.query(with: query)
//                .subscribe(onNext: { wallet in
//                    observer.onNext(wallet)
//                })
//
//            return Disposables.create {
//                serviceDisposable.dispose()
//                repoDisposable.dispose()
//            }
//        }
    }
}

struct ToggleFavoriteUseCaseReqValue {
    let deliveryUUID: String
}
