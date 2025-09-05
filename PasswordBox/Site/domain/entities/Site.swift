//
//  Site.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import SwiftData

struct Site: Hashable, Equatable {
    var id: String = UUID().uuidString
    var siteName: String
    var siteURL: String?
    var createDate: Date = Date()
    var updateDate: Date = Date()
}
