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

class BaseTableViewCell: UITableViewCell {
    // MARK: - Data Properties
    var defaultSelectionStyle: UITableViewCell.SelectionStyle = .none
    
    // MARK: - Functions
    
    func setupViews() {
        
    }
    
    // MARK: - Overrides
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = defaultSelectionStyle
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DeliveryTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String = "DeliveryTableViewCell"
    
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
    
    private lazy var container: UIView = UIView().with {
        $0.backgroundColor = UIColor.white
        $0.addCornerRadius(16.0)
    }
    
    // MARK: - Functions
    
    internal func setupCell(_ viewModel: DeliveryCellViewModel) {
        labelTitle.text = viewModel.title
        labelLocation.text = viewModel.location
        labelPrice.text = viewModel.price
        imageViewHeart.isHidden = !viewModel.favorite
        guard let url = URL(string: viewModel.image) else { return }
        imageViewItem.kf.setImage(with: url)
        print("uhhhhhmmm \(viewModel.favorite)")
        
    }
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func setupViews() {
        
        backgroundColor = #colorLiteral(red: 0.92900002, green: 0.9330000281, blue: 0.9369999766, alpha: 1)
        
        addSubview(container)
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(defaultPadding)
            $0.top.bottom.equalToSuperview().inset(defaultPadding/2)
        }
        
        container.addSubview(imageViewItem)
        imageViewItem.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(defaultPadding).inset(defaultPadding)
            $0.leading.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(92.0)
        }
        
        container.addSubview(labelTitle)
        labelTitle.snp.makeConstraints {
            $0.top.equalTo(imageViewItem)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        container.addSubview(labelLocation)
        labelLocation.snp.makeConstraints {
            $0.top.equalTo(labelTitle.snp.bottom).offset(defaultPadding)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        container.addSubview(imageViewPoints)
        imageViewPoints.snp.makeConstraints {
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.bottom.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(1)
        }
        
        container.addSubview(labelPrice)
        labelPrice.snp.makeConstraints {
            $0.top.equalTo(labelLocation.snp.bottom).offset(defaultPadding)
            $0.bottom.equalToSuperview().inset(defaultPadding)
            $0.leading.equalTo(imageViewItem.snp.trailing).offset(defaultPadding)
            $0.trailing.equalToSuperview().inset(defaultPadding)
        }
        
        container.addSubview(imageViewHeart)
        imageViewHeart.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview().inset(defaultPadding)
            $0.height.width.equalTo(32)
        }
    }
}
