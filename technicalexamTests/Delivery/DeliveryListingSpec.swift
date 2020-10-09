//
//  DeliveryListingSpec.swift
//  technicalexamTests
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
import Moya
import RealmSwift
import RxBlocking
import RxTest
import RxSwift
import RxNimble

@testable import technicalexam

class DeliveryListingSpec: QuickSpec {
    
    var testRealm: Realm!
    
    override func spec() {

        describe("delivery page") {
            var serviceProvider: MoyaProvider<DeliveryService>!
            var repoProvider: RealmRepository<DeliveryPage>!
            var fetchDeliveryUseCase: DefaultFetchDeliveryUseCase!
            var viewModel: DeliveryListingViewModel!
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!
            
            beforeSuite {
                self.testRealm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: self.name))
            }
            
            context("on successful response") {
                beforeEach {
                    serviceProvider = MoyaProvider<DeliveryService>(
                        endpointClosure: self.customEndpointClosureSuccess,
                        stubClosure: MoyaProvider.immediatelyStub)
                    
                    repoProvider = RealmRepository<DeliveryPage>(realm: self.testRealm)
                    
                    fetchDeliveryUseCase = DefaultFetchDeliveryUseCase(
                        deliveryService: serviceProvider,
                        deliveryRepository: repoProvider)
                    
                    viewModel = DeliveryListingViewModel(defaultFetchDeliveryPageUseCase: fetchDeliveryUseCase)
                    
                    scheduler = TestScheduler(initialClock: 0)
                    
                    disposeBag = DisposeBag()
                }
                
                afterEach {
                    try! self.testRealm.write {
                        self.testRealm.deleteAll()
                    }
                }
                
                it("can list deliveries") {
                    viewModel.inputs.viewDidLoad()
                    
                    let deliveries = try! viewModel.outputs.deliveries.toBlocking().first()
                    
                    expect(deliveries?.first?.deliveries.count)
                        .to(equal(5))
                }
                
                it("can paginate") {
                    let deliveryPagesCount = scheduler.createObserver(Int.self)
                    
                    viewModel.outputs.deliveries.asObservable()
                        .map { $0.count }
                        .bind(to: deliveryPagesCount)
                        .disposed(by: disposeBag)
                    
                    scheduler.createColdObservable([Recorded.next(1, ())])
                        .subscribe(onNext: { event in
                            viewModel.viewDidLoad()
                        }).disposed(by: disposeBag)
                    
                    scheduler.createColdObservable([Recorded.next(5, ())])
                        .subscribe(onNext: { event in
                            viewModel.nextPage(page: 1)
                        }).disposed(by: disposeBag)
                    
                    scheduler.start()
                    
                    print("events \(deliveryPagesCount.events)")
                    
                    /// starts with zero cause db has zero data on it
                    expect(deliveryPagesCount.events)
                        .to(equal([Recorded.next(0,0),
                                   Recorded.next(1,1),
                                   Recorded.next(5,1)]))
                }
                
                it("can refresh") {
                    
                    let deliveryPagesCount = scheduler.createObserver(Int.self)
                    
                    viewModel.outputs.deliveries.asObservable()
                        .map { $0.count }
                        .bind(to: deliveryPagesCount)
                        .disposed(by: disposeBag)
                    
                    scheduler.createColdObservable([Recorded.next(5, ())])
                        .subscribe(onNext: { event in
                            viewModel.viewDidLoad()
                        }).disposed(by: disposeBag)
                    
                    scheduler.createColdObservable([Recorded.next(20, ())])
                        .subscribe(onNext: { event in
                            viewModel.refresh()
                        }).disposed(by: disposeBag)
                    
                    scheduler.start()
                    
                    /// starts with zero cause db has zero data on it
                    expect(deliveryPagesCount.events)
                        .to(equal([Recorded.next(0,0),
                                   Recorded.next(5,1),
                                   Recorded.next(20,1)]))
                }
            }
        }
    }
    
    func customEndpointClosureSuccess(_ target: DeliveryService) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, StubDataHelper.shared.generateResponseDataFromResourceJSON(fileName: "delivery_json_success")) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
}
