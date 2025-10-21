//
//  AccountDescendingSorter.swift
//  PasswordBox
//
//  Created by 이민호 on 10/13/25.
//

import Foundation

struct AccountDescendingSorter: AccountSortable {
    func sort(accounts: [AccountInfoWrapper], by: AccountOrderBy) -> [AccountInfoWrapper] {
        switch by {
        case .title:
            return sortByTitle(accounts: accounts)
        case .createDate:
            return sortByCreateDate(accounts: accounts)
        case .updateDate:
            return sortByUpdateDate(accounts: accounts)
        }
    }
    
    private func sortByTitle(accounts: [AccountInfoWrapper]) -> [AccountInfoWrapper] {
        return accounts.sorted { $0.sitename > $1.sitename }
    }
    
    private func sortByCreateDate(accounts: [AccountInfoWrapper]) -> [AccountInfoWrapper] {
        return accounts.sorted { $0.createDate > $1.createDate }
    }
    
    private func sortByUpdateDate(accounts: [AccountInfoWrapper]) -> [AccountInfoWrapper] {
        return accounts.sorted { $0.updateDate > $1.updateDate }
    }
}
