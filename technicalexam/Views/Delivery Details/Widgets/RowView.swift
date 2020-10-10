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
        $0.font = .systemFont(ofSize: 12)
        $0.text = "#0000000"
        $0.textColor = #colorLiteral(red: 0.2590000033, green: 0.09399999678, blue: 0.4120000005, alpha: 1)
    }
    
    let labelDetails = UILabel().with {
        $0.font = .systemFont(ofSize: 16)
        $0.text = "From"
        $0.textColor = #colorLiteral(red: 0.5059999824, green: 0.5329999924, blue: 0.5490000248, alpha: 1)
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
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(self.snp.centerX)
        }
        
        addSubview(labelDetails)
        labelDetails.snp.makeConstraints {
            $0.leading.equalTo(self.snp.centerX)
            $0.bottom.trailing.equalToSuperview()
        }
    }
}

