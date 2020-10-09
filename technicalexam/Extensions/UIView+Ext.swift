//
//  UIView+Ext.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addCornerRadius(
        _ cornerRadius: CGFloat = 6,
        borderColor: UIColor = UIColor.clear,
        borderWidth: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    
    func addShadow(
        xAxis: CGFloat = 0,
        yAxis: CGFloat = 3.0,
        blur: CGFloat = 5.0,
        opacity: Float = 0.5,
        shadowColor: CGColor = #colorLiteral(red: 0.5058823529, green: 0.5333333333, blue: 0.5490196078, alpha: 1).cgColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = CGSize(width: xAxis, height: yAxis)
        self.layer.shadowRadius = blur
        self.layer.shadowOpacity = opacity
    }
}
