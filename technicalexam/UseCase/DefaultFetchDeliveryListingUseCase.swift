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
                .subscribe(onSuccess: {[weak self] deliveries in
                    guard let self = self else { return }
                    let deliveriesCopy = self.addGeneratedId(to: deliveries, with: requestValue.offset)
                    let deliveryPage = DeliveryPage(deliveries: deliveriesCopy,
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
    
    private func addGeneratedId(to deliveries: [Delivery], with page: Int) -> [Delivery] {
        var deliveriesCopy = deliveries
        for index in deliveriesCopy.indices {
            deliveriesCopy[index].uuid =
                "\(page)+\(deliveriesCopy[index].id ?? "")"
        }
        return deliveriesCopy
    }
}

struct FetchDeliveryUseCaseReqValue {
    let limit: Int
    let offset: Int
}
