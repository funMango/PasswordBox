//
//  AccountDTO.swift
//  PasswordBox
//
//  Created by 이민호 on 8/30/25.
//

import Foundation
import SwiftData

@Model
class AccountDTO {
    var id: String = ""
    var sitename: String = ""       // 검색/정렬용 → String 유지
    var username: Data = Data()     // 🔐 암호문
    var password: Data = Data()     // 🔐 암호문
    var pin: Data? = nil            // 🔐 암호문 (옵션)
    var memo: Data? = nil           // 🔐 암호문 (옵션)
    var createDate: Date = Date()
    var updateDate: Date = Date()
    var order: Int = 0
    
    init(
        id: String = UUID().uuidString,
        sitename: String,
        username: Data,
        password: Data,
        pin: Data?,
        memo: Data?,
        createDate: Date = Date(),
        updateDate: Date = Date(),
        order: Int = 0
    ) {
        self.id = id
        self.sitename = sitename
        self.username = username
        self.password = password
        self.pin = pin
        self.memo = memo
        self.createDate = createDate
        self.updateDate = updateDate
        self.order = order
    }
}

extension AccountDTO {
    func toEntity(using crypto: CryptoManager) throws -> Account {
        return Account(
            id: self.id,
            sitename: self.sitename,
            username: try crypto.decryptString(self.username),
            password: try crypto.decryptString(self.password),
            pin: self.pin != nil ? try crypto.decryptString(self.pin!) : nil,
            memo: self.memo != nil ? try crypto.decryptString(self.memo!) : nil,
            createDate: self.createDate,
            updateDate: self.updateDate
        )
    }
}
