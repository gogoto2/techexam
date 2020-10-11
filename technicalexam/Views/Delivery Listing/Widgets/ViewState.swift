//
//  ViewState.swift
//  technicalexam
//
//  Created by iOS on 10/11/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

class ViewState: UIView {
    
    let imageView = UIImageView().with {
        $0.image = #imageLiteral(resourceName: "error")
    }
    
    let label = UILabel().with {
        $0.text = "Oops! Something went wrong."
        $0.textAlignment = .center
        $0.font = UIFont(name: fontRobotoRegular, size: 16)
    }
    
    let button = BounceButton().with {
        $0.backgroundColor = #colorLiteral(red: 0.9570000172, green: 0.2630000114, blue: 0.2119999975, alpha: 1)
        $0.setTitle("   Retry   ", for: .normal)
        $0.addCornerRadius(16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("CircleView is not NSCoding compliant")
    }
}

extension ViewState {
    private func setUpView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(200)
            $0.center.equalToSuperview()
        }
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(defaultPadding)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(button)
        button.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(defaultPadding)
            $0.centerX.equalToSuperview()
        }
    }
}
