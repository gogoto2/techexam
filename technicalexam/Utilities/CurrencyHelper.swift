//
//  String+Ext.swift
//  technicalexam
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation

extension String {

    func convertCurrencyToDouble(locale: Locale) -> Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        return numberFormatter.number(from: self)?.doubleValue ?? 0
    }
    
    func addFormattedCurrency(with amount: String, locale: Locale) -> String {
        let sum = self.convertCurrencyToDouble(locale: locale) + amount.convertCurrencyToDouble(locale: locale)
        return sum.convertDoubleToCurreny(local: locale)
    }
}

extension Double {
    func convertDoubleToCurreny(local: Locale) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = local
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
