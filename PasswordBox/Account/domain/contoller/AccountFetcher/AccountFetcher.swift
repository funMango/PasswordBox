//
//  AccountFetcher.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation
import Resolver

protocol AccountFetcher {
    func fetchAll() async -> [AccountInfoWrapper]
}

final class DefaultAccountFetcher: AccountFetcher {
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService
    
    func fetchAll() async -> [AccountInfoWrapper] {
        let accounts = await accountService.fetchAll()
        let socialAccounts = await socialAccountService.fetchAll()
        
        let merged = accounts.map(AccountInfoWrapper.account)
                 + socialAccounts.map(AccountInfoWrapper.social)

        return merged.sorted {
            $0.sitename.localizedCaseInsensitiveCompare($1.sitename) == .orderedAscending
        }
    }
}

