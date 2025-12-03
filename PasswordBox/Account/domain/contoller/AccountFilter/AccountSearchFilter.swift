//
//  AccountSearchFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 12/3/25.
//

import Foundation

protocol AccountSearchFilter {
    func filter(accounts: [AccountInfoWrapper], query: String) -> [AccountInfoWrapper]
}

class DefaultAccountSearchFilter: AccountSearchFilter {
    func filter(accounts: [AccountInfoWrapper], query: String) -> [AccountInfoWrapper] {
        let filterdBySitename = filterBySitename(accounts: accounts, query: query)
        let filterdBySocialSitenameOrUsername = filterBySocialSitenameOrUsername(
            accounts: accounts,
            filteredAccounts: filterdBySitename,
            query: query
        )
        
        return filterdBySitename + filterdBySocialSitenameOrUsername
    }
    
    private func filterBySitename(accounts: [AccountInfoWrapper], query: String) -> [AccountInfoWrapper] {
        
        return accounts.filter { $0.matchBySitename(query: query) }
            .sorted { a, b in
                a.sitename.localizedCaseInsensitiveCompare(b.sitename) == .orderedAscending
            }
        
    }
    
    private func filterBySocialSitenameOrUsername(
        accounts: [AccountInfoWrapper],
        filteredAccounts: [AccountInfoWrapper],
        query: String
    ) -> [AccountInfoWrapper] {
        
        return accounts.filter {
            $0.matchBySocialSiteNameOrUsername(query: query) &&
            !filteredAccounts.contains(accounts)
        }
        .sorted { a, b in
            a.sitename.localizedCaseInsensitiveCompare(b.sitename) == .orderedAscending
        }
    }
}
