//
//  Site.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import SwiftData

struct Account: Hashable, Equatable {
    var id: String = UUID().uuidString
    var sitename: String
    var username: String
    var password: String
    var pin: String? = nil
    var memo: String? = nil
    var createDate: Date = Date()
    var updateDate: Date = Date()
}

extension Account: Searchable {
    func matches(by type: AccountFilterType = .sitename, _ query: String) -> Bool {
        switch type {
        case .sitename:
            return sitename.localizedCaseInsensitiveContains(query)
        case .sitenameOrUsername:
            return sitename.localizedCaseInsensitiveContains(query) || username.localizedCaseInsensitiveContains(query)
        }
        
    }
    
//    func matches(by type: AccountFilterType, query: String) -> Bool {
//        return sitename.localizedCaseInsensitiveContains(query) || username.localizedCaseInsensitiveContains(query)
//    }
}
