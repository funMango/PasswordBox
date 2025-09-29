//
//  DefaultAccountFilter.swift
//  PasswordBox
//
//  Created by 이민호 on 9/29/25.
//

import Foundation

final class DefalutAccountFilter: AccountFilter {
    func filtering(accounts: [Account], query: String, excluded: String? = nil) -> [Account] {
        guard !query.isEmpty else { return accounts }
        
        let filterBySitenmae = Spec.sitename(containsCI: query)
        return accounts.filter { filterBySitenmae.isSatisfied($0) }
    }
}
