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
import RxDataSources

// MARK: - Lifecycle

class DeliveryListingViewController: UIViewController {
    
    private let deliveryListingViewModel: DeliveryListingViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource: RxCollectionViewSectionedReloadDataSource<DeliveryListingSection> = {
        let dataSource = RxCollectionViewSectionedReloadDataSource<DeliveryListingSection>(configureCell: {  _, collectionView, indexPath, item  in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryViewCell.identifier, for: indexPath) as? DeliveryViewCell
            cell?.setupCell(DeliveryCellViewModel(delivery: item))
            cell?.toggleWishList.subscribe(onNext: { _ in
               
            }).disposed(by: cell!.disposeBag)
            return cell!
        })
        return dataSource
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize.init(width: 10, height: defaultPadding)
        layout.itemSize = CGSize(width: (screenWidth - 48), height: 108)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9333333333, blue: 0.937254902, alpha: 1)
        collectionView.register(DeliveryViewCell.self, forCellWithReuseIdentifier: DeliveryViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        return collectionView
    }()
    
    private let viewNavbar = ViewNavbar().with {
        $0.backButton.isHidden = true
        $0.labeTitle.text = "Delivery"
    }
    
    init(deliveryListingViewModel: DeliveryListingViewModel) {
        self.deliveryListingViewModel = deliveryListingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpBindings()
    }
}

// MARK: Setup bindings

extension DeliveryListingViewController {
    
    private func setUpBindings() {
        
        deliveryListingViewModel.inputs.viewDidLoad()
  
        deliveryListingViewModel.outputs.error.drive(onNext: { _ in
            print("error asadasdsa")
        })
        
        deliveryListingViewModel.outputs.deliveries
            .asDriver(onErrorJustReturn: [])
            .asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.reachedBottom(offset: 40)
            .asObservable()
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
                self?.deliveryListingViewModel.nextPage()
            }).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Delivery.self)
            .subscribe(onNext: {[weak self] delivery in
                guard let navigationController = self?.navigationController else { return }
                let deliveryCoordinator = DeliveryDetailsCoordinator(
                    navigationController: navigationController,
                    delivery: delivery
                )
                deliveryCoordinator.start()
            }).disposed(by: disposeBag)
    }
}

// MARK: - Setup views

extension DeliveryListingViewController {
    private func setUpViews() {
        view.addSubview(viewNavbar)
        viewNavbar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(viewNavbar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
}
