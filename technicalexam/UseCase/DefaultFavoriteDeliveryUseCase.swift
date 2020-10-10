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

protocol FavoriteUseCase {
    func execute(requestValue: FavoriteUseCaseReqValue)
}

final class DefaultFavoriteUseCase: FavoriteUseCase {
    private var deliveryRepository: RealmRepository<DeliveryPage>
    private var disposeBag = DisposeBag()

    init(deliveryRepository: RealmRepository<DeliveryPage>) {
        self.deliveryRepository = deliveryRepository
    }

    func execute(requestValue: FavoriteUseCaseReqValue) {
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

struct FavoriteUseCaseReqValue {
    let limit: Int
    let fromPage: Int
}
