//
//  AccountCredentials.swift
//  PasswordBox
//
//  Created by 이민호 on 9/9/25.
//

import Foundation

struct AccountCredentials {
    var username: String = ""
    var password: String = ""
    var pin: String? = nil
    var memo: String? = nil
}

extension Optional where Wrapped == String {
    var bound: String {
        get { self ?? "" }
        set { self = newValue.isEmpty ? nil : newValue }
    }
}
