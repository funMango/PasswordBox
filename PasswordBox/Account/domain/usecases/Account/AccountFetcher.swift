//
//  AccountFetcher.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation
import Resolver

protocol AccountFetcher {
    func fetchAll() async throws -> [AccountInfoWrapper]
}

final class DefaultAccountFetcher: AccountFetcher {
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService
    
    func fetchAll() async throws -> [AccountInfoWrapper] {
        let accounts = try await accountService.fetchAll()
        let socialAccounts = try await socialAccountService.fetchAll()
        
        let merged = accounts.map(AccountInfoWrapper.account)
                 + socialAccounts.map(AccountInfoWrapper.social)

        return merged.sorted {
            $0.sitename.localizedCaseInsensitiveCompare($1.sitename) == .orderedAscending
        }
    }
}

