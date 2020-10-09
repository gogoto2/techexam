//
//  With.swift
//  technicalexam
//
//  Created by iOS on 10/9/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

protocol With { }

extension With where Self: Any {
    
    /**
     allows you to update the callee with changes in the supplied closure
     
     let foo = SomeType().with {
     $0.text = "Hello World"
     $0.number = 1
     }
     
     - parameter update: the closure that will make the change
     - returns: for value types, a copy of the callee with the changes in the closure applied.
     For reference types, the callee with the changes in the closure applied
     
     */
    func with(_ update: (inout Self) -> Void) -> Self {
        var copy = self
        update(&copy)
        return copy
    }
    
}

extension UIView: With { }

extension UIBarItem: With { }
