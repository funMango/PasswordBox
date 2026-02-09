//
//  AccountSearchFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 12/3/25.
//

import Foundation

protocol AccountSearchFilter {
    func filter(accounts: [Account], query: String) -> [Account]
    func filterByDate(accounts: [Account]) -> [Account]
}

class DefaultAccountSearchFilter: AccountSearchFilter {
    func filter(accounts: [Account], query: String) -> [Account] {
        let filteredBySitename = filterBySitename(accounts: accounts, query: query)
        let filteredByUsername = filterByUsername(
            accounts: accounts,
            filteredAccounts: filteredBySitename,
            query: query
        )
        return filteredBySitename + filteredByUsername
    }
    
    func filterByDate(accounts: [Account]) -> [Account] {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let recentAccounts = accounts.filter { account in
            account.createDate >= oneWeekAgo ||
            account.updateDate >= oneWeekAgo
        }
        
        return recentAccounts
    }
    
    private func filterBySitename(accounts: [Account], query: String) -> [Account] {
        return accounts.filter { Spec.sitename(by: query).isSatisfied($0) }
            .sorted { a, b in
                a.sitename.localizedCaseInsensitiveCompare(b.sitename) == .orderedAscending
            }
    }
    
    private func filterByUsername(
        accounts: [Account],
        filteredAccounts: [Account],
        query: String
    ) -> [Account] {
        return accounts.filter {
            !filteredAccounts.contains($0) &&
            Spec.username(by: query).isSatisfied($0)
        }
        .sorted { a, b in
            a.sitename.localizedCaseInsensitiveCompare(b.sitename) == .orderedAscending
        }
    }
}


          
           
           
         
         
         
         
    
