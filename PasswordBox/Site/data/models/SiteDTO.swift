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
    var updateDate: Date = Date()
    var order: Int = 0
    
    init(
        id: String = UUID().uuidString,
        siteName: String,
        siteURL: String? = nil,
        updateDate: Date = Date(),
        order: Int = 0
    ) {
        self.id = id
        self.siteName = siteName
        self.siteURL = siteURL
        self.updateDate = updateDate
        self.order = order
    }
    
    func setOrder(_ order: Int) {
        self.order = order
    }
}

extension SiteDTO {
    func toEntity() -> Site {
        return Site(
            id: self.id,
            siteName: self.siteName,
            siteURL: self.siteURL,
            order: self.order
        )
    }
}
