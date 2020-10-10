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
        $0.addCornerRadius(16)
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
        scrollView.backgroundColor = #colorLiteral(red: 0.92900002, green: 0.9330000281, blue: 0.9369999766, alpha: 1)
        scrollView.layer.cornerRadius = 20
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return scrollView
    }()
    
    private lazy var labelPlaceHolderIdAndPickUp = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.font = UIFont(name: fontRobotoBold, size: 16)
        $0.labelPlaceholder.textColor = .white
        
        $0.labelDetails.font = UIFont(name: fontRobotoRegular, size: 18)
        $0.labelDetails.textColor = .white
        $0.labelDetails.text = "Delivery Information"
    }
    
    private lazy var labelPlaceHolderFrom = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "From"
    }
    
    private lazy var labelPlaceHolderTo = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "To"
    }
    
    private lazy var rowDeliveryFee = RowView().with {
        $0.labelTitle.text = "Delivery Fee"
    }
    
    private lazy var rowDeliverySurcharge = RowView().with {
        $0.labelTitle.text = "Surcharge"
    }

    private lazy var rowDeliveryTotal = RowView().with {
        $0.labelTitle.font = UIFont.init(name: fontRobotoRegular, size: 16)
        $0.labelTitle.text = "Total Price"
        $0.labelTitle.textColor = .black
    }
    
    private lazy var labelDeliveryInfo = UILabel().with {
        $0.text = "\nPackage Information"
        $0.numberOfLines = 0
        $0.font = UIFont(name: fontRobotoBold, size: 20)
        $0.textColor = .black
    }
    
    private lazy var viewNavbar = ViewNavbar()
    
    private lazy var labelPlaceHolderDeliveryID = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "Delivery ID"
    }
    
    private lazy var labelPlaceHolderName = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "Name"
    }
    
    private lazy var labelPlaceHolderPhone = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "Phone Number"
    }
    
    private lazy var labelPlaceHolderEmail = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "Email Address"
    }
    
    private lazy var labelPlaceHolderRemarks = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "Remarks"
    }

    private lazy var labelPlaceHolderPickUpTime = LabelWithPlaceHolder().with {
        $0.labelPlaceholder.text = "Pickup Time"
    }
    
    private lazy var buttonFavorites = BounceButton().with {
        $0.setImage(#imageLiteral(resourceName: "icHeart.png"), for: .normal)
    }
    
    private lazy var viewFeeDividerTop = SeparatorView()
    
    private lazy var viewFeeDividerBottom = SeparatorView()
    
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
    
    deinit {
        print("deinitialized")
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
        
        view.backgroundColor = #colorLiteral(red: 0.9570000172, green: 0.2630000114, blue: 0.2119999975, alpha: 1)

        view.addSubview(viewNavbar)
        viewNavbar.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(viewNavbar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.leading.trailing.equalTo(view).inset(defaultPadding * 2)
        }
        
        view.addSubview(buttonFavorites)
        buttonFavorites.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).inset(-50)
            make.width.height.equalTo(100)
            make.trailing.equalToSuperview().inset(20)
        }
        
        viewNavbar.addSubview(imageViewGoods)
        imageViewGoods.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().inset(40)
            $0.height.width.equalTo(70)
        }
        
        viewNavbar.addSubview(labelPlaceHolderIdAndPickUp)
        labelPlaceHolderIdAndPickUp.snp.makeConstraints {
            $0.leading.equalTo(imageViewGoods.snp.trailing).offset(defaultPadding)
            $0.centerY.equalTo(imageViewGoods)
            $0.trailing.equalToSuperview()
        }
       
        stackView.addArrangedSubview(labelPlaceHolderFrom)
        stackView.addArrangedSubview(labelPlaceHolderTo)
        stackView.addArrangedSubview(viewFeeDividerTop)
        stackView.addArrangedSubview(rowDeliveryFee)
        stackView.addArrangedSubview(rowDeliverySurcharge)
        stackView.addArrangedSubview(viewFeeDividerBottom)
        stackView.addArrangedSubview(rowDeliveryTotal)
        stackView.addArrangedSubview(labelDeliveryInfo)
        stackView.addArrangedSubview(labelPlaceHolderDeliveryID)
        stackView.addArrangedSubview(labelPlaceHolderName)
        stackView.addArrangedSubview(labelPlaceHolderPhone)
        stackView.addArrangedSubview(labelPlaceHolderEmail)
        stackView.addArrangedSubview(labelPlaceHolderRemarks)
        stackView.addArrangedSubview(labelPlaceHolderPickUpTime)
                
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(defaultPadding * 3)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Bind Views

extension DeliveryDetailsViewController {
    
    private func bindViews() {
        
        viewNavbar.backButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
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
            .packageId
            .drive(labelPlaceHolderDeliveryID.labelDetails.rx.text)
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
            .remarks
            .drive(labelPlaceHolderRemarks.labelDetails.rx.text)
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
