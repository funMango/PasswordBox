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
    var sortOrderRaw: String = SiteOrder.ascending.rawValue
    var sortByRaw: String = SiteOrderBy.title.rawValue
    
    var sortOrder: SiteOrder {
        get { SiteOrder(rawValue: sortOrderRaw) ?? .ascending }
        set { sortOrderRaw = newValue.rawValue }
    }
        
    var sortBy: SiteOrderBy {
        get { SiteOrderBy(rawValue: sortByRaw) ?? .title }
        set { sortByRaw = newValue.rawValue }
    }
    
    init(
        id: String = UUID().uuidString,
        sortOrder: SiteOrder = .ascending,
        sortBy: SiteOrderBy = .title
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
