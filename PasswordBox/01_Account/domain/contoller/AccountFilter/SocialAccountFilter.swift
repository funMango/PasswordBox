//
//  AccountFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 9/29/25.
//

import Foundation

final class SocialAccountFilter: AccountFilter {
    func filtering(accounts: [Account], query: String, excluded: String?) -> [Account] {
        if !query.isEmpty && excluded == nil {
            return queryFiltering(accounts: accounts, query: query)
        }
        
        if query.isEmpty && excluded != nil {
            return excludedFiltering(accounts: accounts, excluded: excluded!)
        }
        
        if !query.isEmpty && excluded != nil {
            return queryAndExcludedFiltering(accounts: accounts, query: query, excluded: excluded!)
        }
        
        return accounts
    }
    
    private func queryFiltering(accounts: [Account], query: String) -> [Account] {
        let filterBySitename = Spec<Account>.sitename(containsCI: query)
        let filterByUsername = Spec<Account>.username(containsCI: query)
        let predicate = filterBySitename.or(filterByUsername)
        return accounts.filter { predicate.isSatisfied($0) }
    }
    
    private func excludedFiltering(accounts: [Account], excluded: String) -> [Account] {
        let excludedSitename = Spec<Account>.sitename(not: excluded)
        return accounts.filter { excludedSitename.isSatisfied($0) }
    }
    
    private func queryAndExcludedFiltering(accounts: [Account], query: String, excluded: String) -> [Account] {
        let filtered = queryFiltering(accounts: accounts, query: query)
        let excludedFiltered = excludedFiltering(accounts: filtered, excluded: excluded)
        return excludedFiltered
    }
}
