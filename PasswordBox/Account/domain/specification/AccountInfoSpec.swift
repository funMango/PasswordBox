//
//  AccountInfoSpec.swift
//  PasswordBox
//
//  Created by 이민호 on 10/2/25.
//

import Foundation

extension Spec where T == AccountInfoWrapper {
    // 포함(대소문자 무시)
    static func sitename(by keyword: String) -> Spec {
        Spec { $0.sitename.localizedCaseInsensitiveContains(keyword) }
    }
    static func username(by keyword: String) -> Spec {
        Spec { ($0.username?.localizedCaseInsensitiveContains(keyword)) ?? false }
    }

    // 정확 일치
    static func sitename(equalTo value: String) -> Spec {
        Spec { $0.sitename == value }
    }
    static func username(equalTo value: String) -> Spec {
        // Optional(String)과 String 비교는 일반적으로 허용됩니다(값을 Optional로 승격).
        // 보다 명시적으로 하려면: ($0.username?.elementsEqual(value)) ?? false
        Spec { $0.username == value }
    }

    // 제외
    static func sitename(except value: String) -> Spec {
        Spec { $0.sitename != value }
    }
    static func username(except value: String) -> Spec {
        // 마찬가지로 Optional 비교. 명시적으로 하려면: !(($0.username?.elementsEqual(value)) ?? false)
        Spec { $0.username != value }
    }
}
