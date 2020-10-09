//
//  DeliveryListingViewModel.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import RealmSwift
import RxOptional

protocol DeliveryListingViewModelInputs {
    func viewDidLoad()
    func nextPage(page: Int)
    func refresh()
}

protocol DeliveryListingViewModelOutputs {
    var error: Driver<String>! { get }
    var deliveries: Driver<[DeliveryListingSection]>! { get }
    var isLoading: Driver<Bool>! { get }
}

protocol DeliveryListingViewModelType {
    var inputs: DeliveryListingViewModelInputs { get }
    var outputs: DeliveryListingViewModelOutputs { get }
}

final class DeliveryListingViewModel: DeliveryListingViewModelType, DeliveryListingViewModelInputs, DeliveryListingViewModelOutputs {
 
    var inputs: DeliveryListingViewModelInputs { return self }
    var outputs: DeliveryListingViewModelOutputs { return self }
    
    // MARK: - Inputs
  
    var viewDidLoadProperty = PublishSubject<Void?>()
    func viewDidLoad() {
        self.viewDidLoadProperty.onNext(())
    }
    
    var nextPageProperty = PublishSubject<Int>()
    func nextPage(page: Int) {
        self.nextPageProperty.onNext(page)
    }
    
    private var refreshProperty = PublishSubject<Void>()
    func refresh() {
        self.refreshProperty.onNext(())
    }
    
    // MARK: - Outputs
    
    internal var error: Driver<String>!
    internal var deliveries: Driver<[DeliveryListingSection]>!
    internal var isLoading: Driver<Bool>!
    
    // MARK: - Attributes
    
    private let disposeBag = DisposeBag()
    private let offset = 25
    
    init(defaultFetchDeliveryPageUseCase: DefaultFetchDeliveryUseCase) {
        
        let deliveryRequest = nextPageProperty
            .flatMapLatest {[weak self] page -> Observable<LoadingResult<[DeliveryPage]>> in
                let requestValue = FetchDeliveryUseCaseReqValue(page: page, offset: self?.offset ?? 0)
                return defaultFetchDeliveryPageUseCase.execute(requestValue: requestValue)
                    .monitorResult()
            }.share()
        
        let deliveryResponse = BehaviorRelay<[DeliveryPage]>(value: [])

        deliveryRequest.elements()
            .bind(to: deliveryResponse)
            .disposed(by: disposeBag)
        
        self.deliveries = deliveryResponse
            .map {
                return $0.compactMap { page in
                    DeliveryListingSection(items: page.deliveries)
                }
            }.asDriver(onErrorJustReturn: [])
        
        self.viewDidLoadProperty
            .filterNil()
            .map { _ in 1 }
            .subscribe(onNext: {[weak self] page in
                self?.nextPageProperty.onNext(page)
            }).disposed(by: disposeBag)
        
        self.refreshProperty
            .bind(to: viewDidLoadProperty)
            .disposed(by: disposeBag)

        self.error = deliveryRequest.errors()
            .debug("errors")
            .map { $0.localizedDescription }
            .asDriver(onErrorJustReturn: "Unknown Error")
        
        self.isLoading = deliveryRequest.loading()
            .asDriver(onErrorJustReturn: false)
    }
}
