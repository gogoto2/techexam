//
//  DeliveryViewCellHeader.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

class DeliveryViewCellHeaderViewCell: UICollectionReusableView {
    
    static var identifier: String = "DeliveryViewCellHeaderViewCell"
    
    private lazy var labelHeader = UILabel().with {
        $0.text = "Deliveries"
        $0.textColor = #colorLiteral(red: 0.2588235294, green: 0.09411764706, blue: 0.4117647059, alpha: 1)
        $0.font = .systemFont(ofSize: 30)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(labelHeader)
        self.labelHeader.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(defaultPadding)
            $0.leading.trailing.equalToSuperview().inset(defaultPadding)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
