//
//  AccountSorter.swift
//  PasswordBox
//
//  Created by 이민호 on 10/6/25.
//

import Foundation

protocol AccountSortable {
    func sort(accounts: [AccountInfoWrapper], by: AccountOrderBy) -> [AccountInfoWrapper]
}

struct AccountSorter {
    func sortByTitle(accounts: [AccountInfoWrapper], order: AccountOrder, by: AccountOrderBy) -> [AccountInfoWrapper] {
        
        return []
    }
}
