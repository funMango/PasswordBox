//
//  SocialAccount.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import Foundation

struct SocialAccount {
    var id: String = UUID().uuidString
    var sitename: String
    var socialSitename: String
    var username: String? = nil
    var accountId: String? = nil
    var createDate: Date = Date()
    var updateDate: Date = Date()
}
