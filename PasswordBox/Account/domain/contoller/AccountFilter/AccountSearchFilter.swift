//
//  AccountSearchFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 12/3/25.
//

import Foundation

protocol AccountSearchFilter {
    func filter(accounts: [AccountInfoWrapper], query: String) -> [AccountInfoWrapper]
    func filterByDate(accounts: [AccountInfoWrapper]) -> [AccountInfoWrapper]
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
    
    func filterByDate(accounts: [AccountInfoWrapper]) -> [AccountInfoWrapper] {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let recentAccounts = accounts.filter { account in
            account.createDate >= oneWeekAgo ||
            account.updateDate >= oneWeekAgo
        }
        
        return recentAccounts
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
            !filteredAccounts.contains($0) &&
            $0.matchBySocialSiteNameOrUsername(query: query)
        }
        .sorted { a, b in
            a.sitename.localizedCaseInsensitiveCompare(b.sitename) == .orderedAscending
        }
    }
}


          
           
           
         
         
         
         
    
