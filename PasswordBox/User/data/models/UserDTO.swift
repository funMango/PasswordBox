//
//  SiteAlignmentDTO.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation
import SwiftData

@Model
class UserDTO {
    var id: String = ""
    var sortOrderRaw: String = AccountOrder.ascending.rawValue
    var sortByRaw: String = AccountOrderBy.title.rawValue
    
    var sortOrder: AccountOrder {
        get { AccountOrder(rawValue: sortOrderRaw) ?? .ascending }
        set { sortOrderRaw = newValue.rawValue }
    }
        
    var sortBy: AccountOrderBy {
        get { AccountOrderBy(rawValue: sortByRaw) ?? .title }
        set { sortByRaw = newValue.rawValue }
    }
    
    init(
        id: String = UUID().uuidString,
        sortOrder: AccountOrder = .ascending,
        sortBy: AccountOrderBy = .title
    ) {
        self.id = id
        self.sortOrder = sortOrder
        self.sortBy = sortBy
    }
}

extension UserDTO {
    func toEntity() -> User {
        return User(
            id: self.id,
            siteOrder: self.sortOrder,
            siteOrderBy: self.sortBy
        )
    }
}
