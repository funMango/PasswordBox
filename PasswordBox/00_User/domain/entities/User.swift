//
//  SiteAlignment.swift
//  PasswordBox
//
//  Created by 이민호 on 9/4/25.
//

import Foundation

struct User {
    var id: String = UUID().uuidString
    var siteOrder: AccountOrder = .ascending
    var siteOrderBy: AccountOrderBy = .title
}
