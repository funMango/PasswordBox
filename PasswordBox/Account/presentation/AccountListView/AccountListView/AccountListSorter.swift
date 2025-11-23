//
//  AccountListManager.swift
//  PasswordBox
//
//  Created by 이민호 on 11/21/25.
//

import Foundation
import Combine

protocol AccountListSorter {
    func sort(wrappers: [AccountInfoWrapper], orderBy: AccountOrderBy, order: AccountOrder) -> [AccountInfoWrapper]
}

class DefaultAccountListSorter: AccountListSorter {
    func sort(wrappers: [AccountInfoWrapper], orderBy: AccountOrderBy, order: AccountOrder) -> [AccountInfoWrapper] {
        switch orderBy {
        case .title:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.sitename < $1.sitename }
            case .descending:
                return wrappers.sorted { $0.sitename > $1.sitename }
            }
        case .createDate:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.createDate < $1.createDate }
            case .descending:
                return wrappers.sorted { $0.createDate > $1.createDate }
            }
        case .updateDate:
            switch order {
            case .ascending:
                return wrappers.sorted { $0.updateDate < $1.updateDate }
            case .descending:
                return wrappers.sorted { $0.updateDate > $1.updateDate }
            }
        }
    }
}
