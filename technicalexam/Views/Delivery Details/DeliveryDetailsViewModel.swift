//
//  DeliveryDetailsViewModel.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//
import RxCocoa
import RxSwift
import RealmSwift
import RxOptional

protocol DeliveryDetailsViewModelInputs {
    func configure(delivery: Delivery)
    func toggleFavorites()
}

protocol DeliveryDetailsViewModelOutputs {
    var packageId: Driver<String> { get }
    var packagePhoto: Driver<String> { get }
    var routeFrom: Driver<String> { get }
    var routeTo: Driver<String> { get }
    var deliveryFee: Driver<String> { get }
    var surchage: Driver<String> { get }
    var senderName: Driver<String> { get }
    var senderPhone: Driver<String> { get }
    var senderEmail: Driver<String> { get }
    var totalFee: Driver<String> { get }
    var pickUpTime: Driver<String> { get }
    var remarks: Driver<String> { get }
    var favoriteButtonImage: Driver<UIImage> { get }
}

protocol DeliveryDetailsViewModelType {
    var inputs: DeliveryDetailsViewModelInputs { get }
    var outputs: DeliveryDetailsViewModelOutputs { get }
}

final class DeliveryDetailsViewModel: DeliveryDetailsViewModelType, DeliveryDetailsViewModelInputs, DeliveryDetailsViewModelOutputs {
    
    var inputs: DeliveryDetailsViewModelInputs { return self }
    var outputs: DeliveryDetailsViewModelOutputs { return self }
    
    // MARK: - Inputs
  
    private var configureProperty = BehaviorRelay<Delivery?>(value: nil)
    func configure(delivery: Delivery) {
        configureProperty.accept(delivery)
    }
    
    private var toggleProperty = PublishSubject<Void>()
    func toggleFavorites() {
        toggleProperty.onNext(())
    }
    
    // MARK: - Outputs
    
    internal var packageId: Driver<String>
    internal var packagePhoto: Driver<String>
    internal var routeFrom: Driver<String>
    internal var routeTo: Driver<String>
    internal var deliveryFee: Driver<String>
    internal var surchage: Driver<String>
    internal var totalFee: Driver<String>
    internal var senderName: Driver<String>
    internal var senderPhone: Driver<String>
    internal var senderEmail: Driver<String>
    internal var pickUpTime: Driver<String>
    internal var remarks: Driver<String>
    internal var favoriteButtonImage: Driver<UIImage>
    
    // MARK: - Attributes
    
    private let disposeBag = DisposeBag()
    private let limit = 10
    
    init(defaultToggleFavoritesUseCase: DefaultToggleFavoriteUseCase) {
    
        self.packageId = configureProperty
            .filterNil()
            .compactMap { $0.id }
            .asDriver(onErrorJustReturn: "")
        
        self.packagePhoto = configureProperty
            .filterNil()
            .compactMap { $0.goodsPicture }
            .asDriver(onErrorJustReturn: "")
        
        let favoriteImage = BehaviorRelay<UIImage>(value: #imageLiteral(resourceName: "icHeart.png"))
        
        self.favoriteButtonImage = favoriteImage
            .asDriver(onErrorJustReturn: #imageLiteral(resourceName: "icHeart.png"))
            
        self.configureProperty
            .filterNil()
            .compactMap { $0.favorite ?? false ? #imageLiteral(resourceName: "icHeartFilled.png") : #imageLiteral(resourceName: "icHeart.png") }
            .bind(to: favoriteImage)
            .disposed(by: disposeBag)
    
        self.toggleProperty
            .withLatestFrom(configureProperty)
            .filterNil()
            .flatMapLatest { delivery -> Observable<Bool> in
                let requestVale = ToggleFavoriteUseCaseReqValue.init(deliveryUUID: delivery.uuid ?? "")
                return defaultToggleFavoritesUseCase.execute(requestValue: requestVale)
            }.compactMap { $0 ? #imageLiteral(resourceName: "icHeartFilled.png") : #imageLiteral(resourceName: "icHeart.png") }
            .bind(to: favoriteImage)
            .disposed(by: disposeBag)
    
        self.deliveryFee = configureProperty
            .filterNil()
            .compactMap { $0.deliveryFee }
            .asDriver(onErrorJustReturn: "")
        
        self.surchage = configureProperty
            .filterNil()
            .compactMap { $0.surcharge }
            .asDriver(onErrorJustReturn: "")
        
        self.totalFee = configureProperty
            .filterNil()
            .compactMap {
                $0.deliveryFee?.addFormattedCurrency(with: $0.surcharge ?? "", locale: Locale.current)
            }
            .asDriver(onErrorJustReturn: "")
        
        self.routeFrom = configureProperty
            .filterNil()
            .compactMap { $0.route?.start }
            .asDriver(onErrorJustReturn: "")
    
        self.routeTo = configureProperty
            .filterNil()
            .compactMap { $0.route?.end }
            .asDriver(onErrorJustReturn: "")
        
        self.senderName = configureProperty
            .filterNil()
            .compactMap { $0.sender?.name }
            .asDriver(onErrorJustReturn: "")
        
        self.senderPhone = configureProperty
            .filterNil()
            .compactMap { $0.sender?.phone }
            .asDriver(onErrorJustReturn: "")
        
        self.senderEmail = configureProperty
            .filterNil()
            .compactMap { $0.sender?.email }
            .asDriver(onErrorJustReturn: "")
        
        self.pickUpTime = configureProperty
            .filterNil()
            .compactMap { $0.pickupTime?.toDateFormatted() }
            .asDriver(onErrorJustReturn: "")
        
        self.remarks = configureProperty
            .filterNil()
            .compactMap { $0.remarks }
            .asDriver(onErrorJustReturn: "")
    }
}
