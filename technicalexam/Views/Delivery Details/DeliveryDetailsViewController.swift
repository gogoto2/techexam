//
//  DeliveryDetailsViewController.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//
import Foundation
import UIKit
import RxSwift
import RxDataSources

// MARK: - Properties/Overrides

class DeliveryDetailsViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    internal let contentView = UIView().with {
        $0.clipsToBounds = true
    }
    
    internal var imageViewGoods = UIImageView().with {
        $0.addShadow()
        $0.addCornerRadius()
    }
    
    internal var labelPickUpTime = UILabel().with {
        $0.font = .systemFont(ofSize: 12)
        $0.text = "Today"
        $0.textColor = #colorLiteral(red: 0.2590000033, green: 0.09399999678, blue: 0.4120000005, alpha: 1)
    }
    
    internal var labelTo = UILabel().with {
        $0.font = .systemFont(ofSize: 16)
        $0.text = "To Address"
        $0.textColor = #colorLiteral(red: 0.5059999824, green: 0.5329999924, blue: 0.5490000248, alpha: 1)
    }

    private lazy var scrollView: UIScrollView = {
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        let scrollView = UIScrollView(frame: frame)
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private lazy var labelPlaceHolderIdAndPickUp = LabelWithPlaceHolder()
    
    private lazy var labelPlaceHolderFrom = LabelWithPlaceHolder()
    
    private lazy var labelPlaceHolderTo = LabelWithPlaceHolder()
    
    private lazy var rowDeliveryFee = RowView()
    
    private lazy var rowDeliverySurcharge = RowView()

    private lazy var rowDeliveryTotal = RowView()
    
    private lazy var labelPlaceHolderName = LabelWithPlaceHolder()
    
    private lazy var labelPlaceHolderPhone = LabelWithPlaceHolder()
    
    private lazy var labelPlaceHolderEmail = LabelWithPlaceHolder()

    private lazy var labelPlaceHolderPickUpTime = LabelWithPlaceHolder()
    
    private let stackView = UIStackView().with {
        $0.distribution = .equalSpacing
        $0.axis = .vertical
    }
    
    private var deliveryDetailsViewModel: DeliveryDetailsViewModel
    
    private var delivery: Delivery
    
    init(deliveryDetailsViewModel: DeliveryDetailsViewModel,
         delivery: Delivery) {
        self.deliveryDetailsViewModel = deliveryDetailsViewModel
        self.delivery = delivery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle

extension DeliveryDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
    }
}

// MARK: - Setup View

extension DeliveryDetailsViewController {
    private func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.92900002, green: 0.9330000281, blue: 0.9369999766, alpha: 1)
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(view)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view)
        }
        
        contentView.addSubview(imageViewGoods)
        imageViewGoods.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.height.width.equalTo(40)
        }
        
        contentView.addSubview(labelPlaceHolderIdAndPickUp)
        labelPlaceHolderIdAndPickUp.snp.makeConstraints {
            $0.leading.equalTo(imageViewGoods.snp.trailing)
            $0.top.trailing.equalToSuperview()
        }
       
        stackView.addArrangedSubview(labelPlaceHolderFrom)
        stackView.addArrangedSubview(labelPlaceHolderTo)
        stackView.addArrangedSubview(rowDeliveryFee)
        stackView.addArrangedSubview(rowDeliverySurcharge)
        stackView.addArrangedSubview(rowDeliveryTotal)
        stackView.addArrangedSubview(labelPlaceHolderName)
        stackView.addArrangedSubview(labelPlaceHolderPhone)
        stackView.addArrangedSubview(labelPlaceHolderEmail)
        stackView.addArrangedSubview(labelPlaceHolderPickUpTime)
                
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(labelPlaceHolderIdAndPickUp.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Bind Views

extension DeliveryDetailsViewController {
    
    private func bindViews() {
        
        deliveryDetailsViewModel
            .configure(delivery: delivery)
        
        deliveryDetailsViewModel
            .outputs
            .packageId
            .drive(labelPlaceHolderIdAndPickUp.labelPlaceholder.rx.text)
            .disposed(by: disposeBag)
    
        deliveryDetailsViewModel
            .outputs
            .packagePhoto.drive(onNext: {[weak self] photo in
                guard let url = URL(string: photo), let self = self else { return }
                self.imageViewGoods.kf.setImage(with: url)
            }).disposed(by: disposeBag)
        
        deliveryDetailsViewModel
            .outputs
            .routeFrom
            .drive(labelPlaceHolderFrom.labelDetails.rx.text)
            .disposed(by: disposeBag)
    
        deliveryDetailsViewModel
            .outputs
            .routeTo
            .drive(labelPlaceHolderTo.labelDetails.rx.text)
            .disposed(by: disposeBag)
    
        deliveryDetailsViewModel
            .outputs
            .deliveryFee
            .drive(rowDeliveryFee.labelDetails.rx.text)
            .disposed(by: disposeBag)
    
        deliveryDetailsViewModel
            .outputs
            .surchage
            .drive(rowDeliverySurcharge.labelDetails.rx.text)
            .disposed(by: disposeBag)
    
        deliveryDetailsViewModel
            .outputs
            .totalFee
            .drive(rowDeliveryTotal.labelDetails.rx.text)
            .disposed(by: disposeBag)
    
        deliveryDetailsViewModel
            .outputs
            .senderName
            .drive(labelPlaceHolderName.labelDetails.rx.text)
            .disposed(by: disposeBag)
        
        deliveryDetailsViewModel
            .outputs
            .senderPhone
            .drive(labelPlaceHolderPhone.labelDetails.rx.text)
            .disposed(by: disposeBag)
        
        deliveryDetailsViewModel
            .outputs
            .senderEmail
            .drive(labelPlaceHolderEmail.labelDetails.rx.text)
            .disposed(by: disposeBag)
        
        deliveryDetailsViewModel
            .outputs
            .pickUpTime
            .drive(labelPlaceHolderPickUpTime.labelDetails.rx.text)
            .disposed(by: disposeBag)
    }
}
