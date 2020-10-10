//
//  ScrollView+Ext.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation


import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    var currentPage: Observable<Int> {
        return didEndDecelerating.map({
            let pageWidth = self.base.frame.width
            let page = floor((self.base.contentOffset.x - pageWidth / 2) / pageWidth) + 1
            return Int(page)
        })
    }
    
//    var reachedBottom: ControlEvent<Void> {
//        let observable = contentOffset
//            .flatMap { [weak base] contentOffset -> Observable<Void> in
//                guard let scrollView = base else { return Observable.empty() }
//
//                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
//                let yAxis = contentOffset.y + scrollView.contentInset.top
//                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
//
//                return yAxis > threshold ? Observable.just(()) : Observable.empty()
//        }
//        return ControlEvent(events: observable)
//    }
    
    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
           let source = contentOffset.map { contentOffset in
               let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
               let y = contentOffset.y + self.base.contentInset.top
               let threshold = max(offset, self.base.contentSize.height - visibleHeight)
               return y >= threshold
           }
           .distinctUntilChanged()
           .filter { $0 }
           .map { _ in () }
           return ControlEvent(events: source)
       }
    
}

