//
//  BaseTableViewCell.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - FUNCTIONS
    
    func setupViews() {
        
    }
    
    // MARK: - OVERRIDES
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

