//
//  TechnicalExamLabel.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class LabelWithPlaceHolder: UIView {
    
    let labelPlaceholder = UILabel().with {
        $0.font = UIFont.init(name: fontRobotoRegular, size: 14)
        $0.text = "#0000000"
        $0.textColor = #colorLiteral(red: 0.5058823529, green: 0.5333333333, blue: 0.5490196078, alpha: 1)
    }
    
    let labelDetails = UILabel().with {
        $0.font = UIFont.init(name: fontRobotoRegular, size: 16)
        $0.text = "####"
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    init(text: String, placeHolder: String) {
        super.init(frame: .zero)
        labelPlaceholder.text = text
        labelDetails.text = placeHolder
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
}

// MARK: - Setup View

extension LabelWithPlaceHolder {
    
    private func setupView() {
        addSubview(labelPlaceholder)
        labelPlaceholder.snp.makeConstraints {
            $0.top.equalToSuperview().inset(defaultPadding)
            $0.leading.trailing.equalToSuperview()
        }
        
        addSubview(labelDetails)
        labelDetails.snp.makeConstraints {
            $0.top.equalTo(labelPlaceholder.snp.bottom).offset(defaultPadding/2)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(defaultPadding)
        }
    }
}
