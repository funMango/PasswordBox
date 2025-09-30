//
//  AccountFetcher.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation
import Resolver

protocol AccountFetcher {
    func fetchAll() -> [AccountInfoWrapper]
}

final class DefaultAccountFetcher: AccountFetcher {
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService
    
    func fetchAll() -> [AccountInfoWrapper] {
        let accounts = accountService.fetchAll()
        let socialAccounts = socialAccountService.fetchAll()
        
        let merged = accounts.map(AccountInfoWrapper.account)
                 + socialAccounts.map(AccountInfoWrapper.social)

        return merged.sorted {
            $0.sitename.localizedCaseInsensitiveCompare($1.sitename) == .orderedAscending
        }
    }
}

