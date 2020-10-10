//
//  RowView.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RowView: UIView {
    
    let labelTitle = UILabel().with {
        $0.font = UIFont.init(name: fontRobotoRegular, size: 14)
        $0.text = "#0000000"
        $0.textColor = #colorLiteral(red: 0.5058823529, green: 0.5333333333, blue: 0.5490196078, alpha: 1)
    }
    
    let labelDetails = UILabel().with {
        $0.font = UIFont.init(name: fontRobotoRegular, size: 16)
        $0.text = "From"
        $0.textColor = .black
        $0.textAlignment = .right
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

extension RowView {
    
    private func setupView() {
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(defaultPadding/2)
            $0.trailing.equalTo(self.snp.centerX)
        }
        
        addSubview(labelDetails)
        labelDetails.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX)
            $0.top.bottom.equalToSuperview().inset(defaultPadding/2)
            $0.trailing.equalToSuperview()
        }
    }
}
