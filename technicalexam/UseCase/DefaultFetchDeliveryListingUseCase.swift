//
//  DefaultFetchDeliveryListingUseCase.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Moya

protocol FetchDeliveryUseCase {
    func execute(requestValue: FetchDeliveryUseCaseReqValue) -> Observable<[DeliveryPage]>
}

final class DefaultFetchDeliveryUseCase: FetchDeliveryUseCase {
    private var deliveryService: MoyaProvider<DeliveryService>
    private var deliveryRepository: RealmRepository<DeliveryPage>
    private var disposeBag = DisposeBag()

    init(deliveryService: MoyaProvider<DeliveryService>, deliveryRepository: RealmRepository<DeliveryPage>) {
        self.deliveryService = deliveryService
        self.deliveryRepository = deliveryRepository
    }

    func execute(requestValue: FetchDeliveryUseCaseReqValue) -> Observable<[DeliveryPage]> {
        Observable<[DeliveryPage]>.create { observer in
            let serviceDisposable = self.deliveryService.rx
                .request(.getListing(page: requestValue.limit, offset: requestValue.offset))
                .mapArray(Delivery.self)
                .subscribe(onSuccess: { deliveries in
                    let deliveryPage = DeliveryPage(deliveries: deliveries,
                                                    page: requestValue.offset)
                    self.deliveryRepository.save(entity: deliveryPage)
                }, onError: { error in
                    observer.onError(error)
                })

            let query = NSPredicate(format: "page <= %i", requestValue.offset)
            let repoDisposable = self.deliveryRepository.query(with: query)
                .subscribe(onNext: { wallet in
                    observer.onNext(wallet)
                })
            
            return Disposables.create {
                serviceDisposable.dispose()
                repoDisposable.dispose()
            }
        }
    }
    
    private func listenToLocalChanges(observer: AnyObserver<[DeliveryPage]>) {
       
    }
}

struct FetchDeliveryUseCaseReqValue {
    let limit: Int
    let offset: Int
}
