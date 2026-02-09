//
//  DefaultAccountFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 9/29/25.
//

import Foundation

final class DefalutAccountInfoFilter: AccountInfoFilter {
    func filtering(accounts: [Account], query: String, excluded: String?) -> [Account] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let uniqueAccounts = removeDuplicates(accounts)

        if trimmed.isEmpty {
            return uniqueAccounts
        }

        return filtering(accounts: uniqueAccounts, query: query)
    }
    
    func filtering(accounts: [Account], query: String) -> [Account] {
        let filterBySitenmae = Spec.sitename(by: query)
        return accounts.filter { filterBySitenmae.isSatisfied($0) }
    }
    
    
    func removeDuplicates(_ accounts: [Account]) -> [Account] {
        var seen = Set<String>()
        var result: [Account] = []
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
