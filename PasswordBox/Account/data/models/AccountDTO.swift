//
//  SiteDTO.swift
//  PasswordBox
//
//  Created by 이민호 on 8/30/25.
//

import Foundation
import SwiftData

@Model
class AccountDTO {
    var id: String = ""
    var sitename: String = ""
    var username: String = ""
    var password: String = ""
    var pin: String? = nil
    var memo: String? = nil
    var createDate: Date = Date()
    var updateDate: Date = Date()
    var order: Int = 0
    
    init(
        id: String = UUID().uuidString,
        sitename: String,
        username: String,
        password: String,
        pin: String?,
        memo: String?,
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
    func toEntity() -> Account {
        return Account(
            id: self.id,
            sitename: self.sitename,
            username: self.username,
            password: self.password,
            pin: self.pin,
            memo: self.memo,
            createDate: self.createDate,
            updateDate: self.updateDate
        )
    }
}
