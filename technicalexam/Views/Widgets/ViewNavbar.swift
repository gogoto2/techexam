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
    
    private let buttonBack = BounceButton().with {
        $0.setImage(#imageLiteral(resourceName: "icBackArrow.png"), for: .normal)
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
        
        addSubview(buttonBack)
        buttonBack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(40)
        }
    }
}
