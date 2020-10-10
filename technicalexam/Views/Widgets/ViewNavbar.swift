//
//  ViewNavbar.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

class ViewNavbar: UIView {

    private let viewBg = UIView().with {
        $0.backgroundColor = #colorLiteral(red: 0.9570000172, green: 0.2630000114, blue: 0.2119999975, alpha: 1)
    }
    
    let backButton = BounceButton().with {
        $0.setImage(#imageLiteral(resourceName: "icBackArrow.png"), for: .normal)
    }
    
    let labeTitle = UILabel().with {
        $0.textAlignment = .center
        $0.font = UIFont.init(name: fontRobotoBold, size: 20)
        $0.textColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

// MARK: - Setup View

extension ViewNavbar {
    private func setupView() {
        addSubview(viewBg)
        viewBg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(labeTitle)
        labeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
}
