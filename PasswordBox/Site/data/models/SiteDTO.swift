//
//  SiteDTO.swift
//  PasswordBox
//
//  Created by 이민호 on 8/30/25.
//

import Foundation
import SwiftData

@Model
class SiteDTO {
    var id: String = ""
    var siteName: String = ""
    var siteURL: String?
    var createDate: Date = Date()
    var updateDate: Date = Date()
    var order: Int = 0
    
    init(
        id: String = UUID().uuidString,
        siteName: String,
        siteURL: String? = nil,
        createDate: Date = Date(),
        updateDate: Date = Date(),
        order: Int = 0
    ) {
        self.id = id
        self.siteName = siteName
        self.siteURL = siteURL
        self.createDate = createDate
        self.updateDate = updateDate
        self.order = order
    }
}

extension SiteDTO {
    func toEntity() -> Site {
        return Site(
            id: self.id,
            siteName: self.siteName,
            siteURL: self.siteURL,
            createDate: self.createDate,
            updateDate: self.updateDate
        )
    }
}
