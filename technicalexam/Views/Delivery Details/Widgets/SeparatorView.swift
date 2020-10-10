//
//  SeperatorView.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

class SeparatorView: UIView {
    
    let separatorViewLine = SeparatorViewLine()
    
    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubview(separatorViewLine)
        separatorViewLine.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(defaultPadding)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

class SeparatorViewLine: UIView {
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .gray
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0.5)
    }
}
