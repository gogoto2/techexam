//
//  DeliveryListingViewController.swift
//  technicalexam
//
//  Created by iOS on 10/8/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DeliveryListingViewController: UIViewController {
    
    private let deliveryListingViewModel: DeliveryListingViewModel
    private let disposeBag = DisposeBag()
    
    init(deliveryListingViewModel: DeliveryListingViewModel) {
        self.deliveryListingViewModel = deliveryListingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpBindings()
    }
}

// MARK - Private Methods

extension DeliveryListingViewController {
    
    private func setUpBindings() {
        
//        deliveryListingViewModel.inputs.viewDidLoad()
//        
//        deliveryListingViewModel.outputs
//            .deliveries
//            .drive(onNext: { [weak self] message in
//                
//            }).disposed(by: disposeBag)
    }
}
