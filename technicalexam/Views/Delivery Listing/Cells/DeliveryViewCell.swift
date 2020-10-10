//
//  DeliveryTableViewCell.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class DeliveryViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String = "DeliveryViewCell"
    
    var toggleWishList: ControlEvent<Void> {
        return imageViewHeart.rx.tap.asControlEvent()
    }
    
    var disposeBag = DisposeBag()
    
    internal lazy var imageViewItem = UIImageView().with {
        $0.contentMode = .scaleAspectFill
        $0.addCornerRadius(8.0)
        $0.clipsToBounds = true
    }
    
    private lazy var labelTitle = UILabel().with {
        $0.text = ""
        $0.textColor = .black
        $0.font = UIFont(name: fontRobotoRegular, size: 16)
        $0.numberOfLines = 2
    }
    
    private lazy var labelLocation = UILabel().with {
        $0.font = UIFont(name: fontRobotoRegular, size: 14)
        $0.numberOfLines = 0
        $0.textColor = #colorLiteral(red: 0.5059999824, green: 0.5329999924, blue: 0.5490000248, alpha: 1)
    }
    
    private lazy var labelPrice = UILabel().with {
        $0.text = ""
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private lazy var imageViewPoints = UIImageView().with {
        $0.contentMode = .scaleAspectFit
    }
    
    internal let imageViewHeart = BounceButton(frame: .zero).with {
        $0.setImage(#imageLiteral(resourceName: "icHeartFilled.png"), for: .normal)
    }
    
    private lazy var viewBottomControl: UIView = UIView().with {
        $0.backgroundColor = UIColor.white
        $0.addCornerRadius(24)
    }
    
    // MARK: - Functions
    
    internal func setupCell(_ viewModel: DeliveryCellViewModel) {
        labelTitle.text = viewModel.title
        labelLocation.text = viewModel.location
        labelPrice.text = viewModel.price
        imageViewHeart.isHidden = !viewModel.favorite
        guard let url = URL(string: viewModel.image) else { return }
        imageViewItem.kf.setImage(with: url)
    }
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func setupViews() {
        self.backgroundColor = UIColor.white
        self.addCornerRadius(16.0)
        self.addShadow()
        
        addSubview(imageViewItem)
        imageViewItem.snp.makeConstraints {
            $0.top.equalToSuperview().offset(defaultPadding)
            $0.leading.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(92.0)
        }
        
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints {
            $0.top.equalTo(imageViewItem)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        addSubview(labelLocation)
        labelLocation.snp.makeConstraints {
            $0.top.equalTo(labelTitle.snp.bottom).offset(defaultPadding)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        addSubview(imageViewPoints)
        imageViewPoints.snp.makeConstraints {
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.bottom.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(1)
        }
        
        addSubview(labelPrice)
        labelPrice.snp.makeConstraints {
            $0.bottom.equalTo(imageViewPoints.snp.top).offset(-12)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        addSubview(imageViewHeart)
        imageViewHeart.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(32)
        }
    }
}
