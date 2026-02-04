//
//  Spec.swift
//  PasswordBox
//
//  Created by 이민호 on 9/28/25.
//

import Foundation

// 범용 스펙
struct Spec<T> {
    let isSatisfied: (T) -> Bool
    
    func and(_ other: Spec<T>) -> Spec<T> {
        Spec { self.isSatisfied($0) && other.isSatisfied($0) }
    }
    func or(_ other: Spec<T>) -> Spec<T> {
        Spec { self.isSatisfied($0) || other.isSatisfied($0) }
    }
    func not() -> Spec<T> {
        Spec { !self.isSatisfied($0) }
    }
    
    static var alwaysTrue: Spec<T> { Spec { _ in true } }
    static var alwaysFalse: Spec<T> { Spec { _ in false } }
}
