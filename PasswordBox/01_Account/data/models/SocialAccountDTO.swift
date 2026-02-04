//
//  SocialAccountDTO.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import Foundation
import SwiftData

@Model
class SocialAccountDTO {
    var id: String = ""
    var sitename: String = ""    // 🔐 암호문
    var socialSitename: Data = Data() // 🔐 암호문
    var username: Data? = nil  // 🔐 암호문(옵션)
    var accountId: Data? = nil   // 외래키(FK) 🔐 암호문(옵션)
    var createDate: Date = Date()
    var updateDate: Date = Date()
    
    init(
        id: String = UUID().uuidString,
        sitename: String,
        socialSitename: Data,
        username: Data?,
        accountId: Data?,
        createDate: Date = Date(),
        updateDate: Date = Date()
    ) {
        self.id = id
        self.sitename = sitename
        self.socialSitename = socialSitename
        self.username = username
        self.accountId = accountId
        self.createDate = createDate
        self.updateDate = updateDate
    }
}

extension SocialAccountDTO {
    func toEntity(using crypto: CryptoManager) throws -> SocialAccount {
        return SocialAccount(
            id: self.id,
            sitename: self.sitename,
            socialSitename: try crypto.decryptString(self.socialSitename),
            username: self.username != nil ? try crypto.decryptString(self.username!) : nil,
            accountId: self.accountId != nil ? try crypto.decryptString(self.accountId!) : nil,
            createDate: self.createDate,
            updateDate: self.updateDate
        )
    }
}
