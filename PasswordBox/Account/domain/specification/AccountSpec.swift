//
//  AccountSpec.swift
//  PasswordBox
//
//  Created by 이민호 on 9/28/25.
//

import Foundation

extension Spec where T == Account {
    // 포함(대소문자 무시)
    static func sitename(containsCI keyword: String) -> Spec {
        Spec { $0.sitename.localizedCaseInsensitiveContains(keyword) }
    }
    static func username(containsCI keyword: String) -> Spec {
        Spec { $0.username.localizedCaseInsensitiveContains(keyword) }
    }
    // 정확 일치
    static func sitename(equals value: String) -> Spec {
        Spec { $0.sitename == value }
    }
    static func username(equals value: String) -> Spec {
        Spec { $0.username == value }
    }
    // 제외
    static func sitename(not value: String) -> Spec {
        Spec { $0.sitename != value }
    }
    static func username(not value: String) -> Spec {
        Spec { $0.username != value }
    }
    // 다중 제외
    static func username(notIn values: [String]) -> Spec {
        Spec { !values.contains($0.username) }
    }
}
