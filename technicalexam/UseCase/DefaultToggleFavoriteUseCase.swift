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
    private var favoriteRepository: RealmRepository<Favorite>
    private var disposeBag = DisposeBag()

    init(deliveryRepository: RealmRepository<Delivery>, favoriteRepository: RealmRepository<Favorite>) {
        self.deliveryRepository = deliveryRepository
        self.favoriteRepository = favoriteRepository
    }

    func execute(requestValue: ToggleFavoriteUseCaseReqValue) -> Observable<Bool> {
        Observable<Bool>.create { [weak self] observer in
            let repo = self?.deliveryRepository.byPrimaryId(primaryKey: requestValue.deliveryUUID)
                .filterNil()
                .subscribe(onNext: {[weak self] delivery in
                    guard let self = self else { return }
                    
                    if delivery.favorite?.first?.isFavorite == nil {
                        let favorites = Favorite.init(uuid: delivery.uuid ?? "", isFavorite: true, deliveries: [delivery])
                        self.favoriteRepository.save(entity: favorites)
                        observer.onNext(true)
                    } else {
                        let isFavorite = delivery.favorite?.first?.isFavorite ?? false
                        let favorites = Favorite.init(uuid: delivery.uuid ?? "", isFavorite: !isFavorite, deliveries: [delivery])
                        self.favoriteRepository.save(entity: favorites)
                        observer.onNext(!isFavorite)
                    }
                    observer.onCompleted()
                })

             return Disposables.create {
                repo?.dispose()
             }
        }
    }
}

struct ToggleFavoriteUseCaseReqValue {
    let deliveryUUID: String
}
