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
        return self.deliveryRepository.byPrimaryId(primaryKey: requestValue.deliveryUUID)
            .filterNil()
            .flatMapLatest {[weak self] delivery -> Observable<Bool> in
                guard let self = self else { return Observable.just(false) }
                
                if delivery.favorite?.first?.isFavorite == nil {
                    let favorites = Favorite.init(uuid: delivery.uuid ?? "", isFavorite: true, deliveries: [delivery])
                    self.favoriteRepository.save(entity: favorites)
                    return Observable.just(true)
                }
                
                let isFavorite = delivery.favorite?.first?.isFavorite ?? false
                let favorites = Favorite.init(uuid: delivery.uuid ?? "", isFavorite: !isFavorite, deliveries: [delivery])
                self.favoriteRepository.save(entity: favorites)
                return Observable.just(!isFavorite)
            }
        
    }
}

struct ToggleFavoriteUseCaseReqValue {
    let deliveryUUID: String
}
