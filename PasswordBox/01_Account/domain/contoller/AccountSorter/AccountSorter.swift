//
//  AccountSorter.swift
//  PasswordBox
//
//  Created by 이민호 on 10/6/25.
//

import Foundation

protocol AccountSortable {
    func sort(accounts: [Account], by: AccountOrderBy) -> [Account]
}

struct AccountSorter {
    func sortByTitle(accounts: [Account], order: AccountOrder, by: AccountOrderBy) -> [Account] {
        switch order {
        case .ascending:
            return accounts.sorted { $0.sitename < $1.sitename }
        case .descending:
            return accounts.sorted { $0.sitename > $1.sitename }
        }
    }
}
