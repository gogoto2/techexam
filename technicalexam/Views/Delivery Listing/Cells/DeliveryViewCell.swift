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
    
    static var identifier: String = "WishlistCollectionViewCell"
    
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
        $0.textColor = #colorLiteral(red: 0.2588235294, green: 0.09411764706, blue: 0.4117647059, alpha: 1)
        $0.numberOfLines = 2
    }
    
    private lazy var labelSubtitle = UILabel().with {
        $0.text = "3 colours"
        $0.textColor = #colorLiteral(red: 0.5058823529, green: 0.5333333333, blue: 0.5490196078, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var imageViewPoints = UIImageView().with {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var labelPrice = UILabel().with {
        $0.text = "8888"
        $0.textColor = #colorLiteral(red: 0.2588235294, green: 0.09411764706, blue: 0.4117647059, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 2
    }
    
    internal let imageViewHeart = BounceButton(frame: .zero).with {
        $0.setImage(#imageLiteral(resourceName: "icHeartGrayBg.png"), for: .normal)
    }
    
    private lazy var viewBottomControl: UIView = UIView().with {
        $0.backgroundColor = UIColor.white
        $0.addCornerRadius(24)
    }
    
    // MARK: - Functions
    
    internal func setupCell(_ viewModel: DeliveryCellViewModel) {
        labelTitle.text = viewModel.title
        labelPrice.text = viewModel.price
        labelSubtitle.text = viewModel.description
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
        
        addSubview(imageViewPoints)
        imageViewPoints.snp.makeConstraints {
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.bottom.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(1)
        }
        
        addSubview(labelSubtitle)
        labelSubtitle.snp.makeConstraints {
            $0.bottom.equalTo(imageViewPoints.snp.top).offset(-12)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        addSubview(labelPrice)
        labelPrice.snp.makeConstraints {
            $0.top.equalTo(imageViewPoints)
            $0.leading.equalTo(imageViewPoints.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(90)
        }
        
        addSubview(imageViewHeart)
        imageViewHeart.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(32)
        }
    }
}
