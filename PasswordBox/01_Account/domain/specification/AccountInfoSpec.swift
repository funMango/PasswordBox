//
//  AccountInfoSpec.swift
//  PasswordBox
//
//  Created by 이민호 on 10/2/25.
//

import Foundation

extension Spec where T == Account {
    // 포함(대소문자 무시)
    static func sitename(by keyword: String) -> Spec {
        Spec { $0.sitename.localizedCaseInsensitiveContains(keyword) }
    }
    static func username(by keyword: String) -> Spec {
        Spec { $0.username.localizedCaseInsensitiveContains(keyword) }
    }

    // 정확 일치
    static func sitename(equalTo value: String) -> Spec {
        Spec { $0.sitename == value }
    }
    static func username(equalTo value: String) -> Spec {
        Spec { $0.username == value }
    }

    // 제외
    static func sitename(except value: String) -> Spec {
        Spec { $0.sitename != value }
    }
    static func username(except value: String) -> Spec {
        Spec { $0.username != value }
    }
}
