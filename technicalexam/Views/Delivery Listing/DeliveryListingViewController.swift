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
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<DeliveryListingSection> = {
        let dataSource = RxTableViewSectionedReloadDataSource<DeliveryListingSection>(configureCell: {  _, tableView, indexPath, item  in
            let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTableViewCell.identifier, for: indexPath) as? DeliveryTableViewCell
            cell?.setupCell(DeliveryCellViewModel(delivery: item))
            cell?.toggleWishList.subscribe(onNext: { _ in
               
            }).disposed(by: cell!.disposeBag)
            return cell!
        })
        return dataSource
    }()
    
    internal lazy var tableViewDeliveries: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.tableFooterView = loadingStateView
        return tableView
    }()
    
    private lazy var loadingStateView = UIActivityIndicatorView().with {
        $0.frame = CGRect.init(x: 0, y: 20, width: screenWidth, height: 25)
    }
    
    private let viewNavbar = ViewNavbar().with {
        $0.backButton.isHidden = true
        $0.labeTitle.text = "Delivery"
    }
    
    private let viewState = ViewState().with {
        $0.isHidden = true
        $0.backgroundColor = #colorLiteral(red: 0.92900002, green: 0.9330000281, blue: 0.9369999766, alpha: 1)
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
  
        deliveryListingViewModel.outputs.error
            .drive(onNext: {[weak self] _ in
                self?.viewState.isHidden = false
            }).disposed(by: disposeBag)
        
        deliveryListingViewModel.outputs.deliveries
            .asDriver(onErrorJustReturn: [])
            .asObservable()
            .bind(to: tableViewDeliveries.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableViewDeliveries.rx.reachedBottom(offset: 40)
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.deliveryListingViewModel.nextPage()
            }).disposed(by: disposeBag)
        
        tableViewDeliveries.rx.modelSelected(Delivery.self)
            .subscribe(onNext: {[weak self] delivery in
                guard let navigationController = self?.navigationController else { return }
                let deliveryCoordinator = DeliveryDetailsCoordinator(
                    navigationController: navigationController,
                    delivery: delivery
                )
                deliveryCoordinator.start()
            }).disposed(by: disposeBag)
        
        viewState.button.rx.tap.subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.viewState.isHidden = true
                self.deliveryListingViewModel.refresh()
            }).disposed(by: disposeBag)
    }
}

// MARK: - Setup views

extension DeliveryListingViewController {
    private func setUpViews() {
        view.backgroundColor = #colorLiteral(red: 0.92900002, green: 0.9330000281, blue: 0.9369999766, alpha: 1)
        
        view.addSubview(viewNavbar)
        viewNavbar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        view.addSubview(tableViewDeliveries)
        tableViewDeliveries.snp.makeConstraints {
            $0.top.equalTo(viewNavbar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(viewState)
        viewState.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
