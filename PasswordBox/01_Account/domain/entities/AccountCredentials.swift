//
//  AccountCredentials.swift
//  PasswordBox
//
//  Created by 이민호 on 9/9/25.
//

import Foundation

struct AccountCredentials {
    private(set) var sitename: String = ""
    var username: String = ""
    var password: String = ""
    var pin: String? = nil
    private(set) var socialId: String = ""
    var memo: String? = nil
    
    
    mutating func set(sitename: String) {
        self.sitename = sitename
    }
    
    mutating func set(socialId: String) {
        self.socialId = socialId
    }
}


extension Optional where Wrapped == String {
    var bound: String {
        get { self ?? "" }
        set { self = newValue.isEmpty ? nil : newValue }
    }
}
