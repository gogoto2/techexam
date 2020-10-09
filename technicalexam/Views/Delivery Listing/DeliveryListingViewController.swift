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

class DeliveryListingViewController: UIViewController {
    
    private let deliveryListingViewModel: DeliveryListingViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource: RxCollectionViewSectionedReloadDataSource<DeliveryListingSection> = {
        let dataSource = RxCollectionViewSectionedReloadDataSource<DeliveryListingSection>(configureCell: {  _, collectionView, indexPath, item  in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryViewCell.identifier, for: indexPath) as? DeliveryViewCell
            cell?.setupCell(DeliveryCellViewModel(delivery: item))
            cell?.toggleWishList.subscribe(onNext: { _ in
                self.deliveryListingViewModel.nextPage(page: 1)
            }).disposed(by: cell!.disposeBag)
            return cell!
        })
        
        dataSource.configureSupplementaryView = {(dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DeliveryViewCellHeaderViewCell.identifier, for: indexPath) as? DeliveryViewCellHeaderViewCell
            return header!
        }
        return dataSource
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: (screenWidth - 48), height: 70)
        layout.itemSize = CGSize(width: (screenWidth - 48), height: 108)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9333333333, blue: 0.937254902, alpha: 1)
        collectionView.register(DeliveryViewCell.self, forCellWithReuseIdentifier: DeliveryViewCell.identifier)
        collectionView.register(DeliveryViewCellHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DeliveryViewCellHeaderViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        return collectionView
    }()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpBindings()
    }
}

// MARK: Setup bindings

extension DeliveryListingViewController {
    
    private func setUpBindings() {
        deliveryListingViewModel.inputs.viewDidLoad()
  
        deliveryListingViewModel.outputs.deliveries
            .asDriver(onErrorJustReturn: [])
            .asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - Setup views

extension DeliveryListingViewController {
    private func setUpViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
