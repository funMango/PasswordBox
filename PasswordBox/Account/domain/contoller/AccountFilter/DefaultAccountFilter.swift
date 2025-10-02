//
//  DefaultAccountFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 9/29/25.
//

import Foundation

final class DefalutAccountFilter: AccountFilterable {
    func filtering(accounts: [AccountInfoWrapper], query: String, excluded: String?) -> [AccountInfoWrapper] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let uniqueAccounts = removeDuplicates(accounts)

        if trimmed.isEmpty {
            return uniqueAccounts
        }

        return filtering(accounts: uniqueAccounts, query: query)
    }
    
    func filtering(accounts: [AccountInfoWrapper], query: String) -> [AccountInfoWrapper] {
        let filterBySitenmae = Spec.sitename(by: query)
        return accounts.filter { filterBySitenmae.isSatisfied($0) }
    }
    
    
    func removeDuplicates(_ accounts: [AccountInfoWrapper]) -> [AccountInfoWrapper] {
        var seen = Set<String>()
        var result: [AccountInfoWrapper] = []
        result.reserveCapacity(accounts.count)

        for account in accounts {
            let key = account.sitename.lowercased()
            if !seen.contains(key) {
                seen.insert(key)
                result.append(account)
            }
        }

        return result
    }

}





//    func filtering(accounts: [Account], query: String, excluded: String? = nil) -> [Account] {
//        guard !query.isEmpty else { return accounts }
//
//        let filterBySitenmae = Spec.sitename(containsCI: query)
//        return accounts.filter { filterBySitenmae.isSatisfied($0) }
//    }

