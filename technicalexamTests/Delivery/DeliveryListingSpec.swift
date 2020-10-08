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

@testable import technicalexam

class DeliveryListingSpec: QuickSpec {
    
    var testRealm: Realm!
    
    override func spec() {

        describe("delivery page") {
            var serviceProvider: MoyaProvider<DeliveryService>!
            var repoProvider: RealmRepository<DeliveryPage>!
            var fetchDeliveryUseCase: DefaultFetchDeliveryUseCase!
            var viewModel: DeliveryListingViewModel!
            
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
                    viewModel.inputs.viewDidLoad()
                    viewModel.inputs.nextPage(page: 2)
                    
                    let deliveries = try! viewModel.outputs.deliveries.toBlocking().first()
                  
                    expect(deliveries?[0].deliveries.count)
                        .to(equal(5))
                    
                    expect(deliveries?[1].deliveries.count)
                        .to(equal(5))
                    
                    expect(self.testRealm.objects(RealmDeliveryPage.self).count)
                        .to(equal(2))
                    
                    expect(self.testRealm.objects(RealmDelivery.self).count)
                        .to(equal(10))
                }
                
                it("can refresh") {
                    viewModel.inputs.viewDidLoad()
                    viewModel.inputs.nextPage(page: 2)
                    
                    expect(self.testRealm.objects(RealmDeliveryPage.self).count)
                        .to(equal(2))
                    
                    viewModel.inputs.refresh()
                    
                    expect(self.testRealm.objects(RealmDeliveryPage.self).count)
                        .to(equal(1))
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
