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
    var siteName: String = ""
    var createDate: Date = Date()
    var updateDate: Date = Date()
    var order: Int = 0
    
    init(
        id: String = UUID().uuidString,
        siteName: String,
        createDate: Date = Date(),
        updateDate: Date = Date(),
        order: Int = 0
    ) {
        self.id = id
        self.siteName = siteName
        self.createDate = createDate
        self.updateDate = updateDate
        self.order = order
    }
}

extension AccountDTO {
    func toEntity() -> Account {
        return Account(
            id: self.id,
            siteName: self.siteName,            
            createDate: self.createDate,
            updateDate: self.updateDate
        )
    }
}
