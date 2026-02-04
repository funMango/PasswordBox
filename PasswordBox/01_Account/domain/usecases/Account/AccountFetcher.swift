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
    func getWrappers(defaultDTOs: [AccountDTO], socialDTOs: [SocialAccountDTO]) -> [AccountInfoWrapper]
}

final class DefaultAccountFetcher: AccountFetcher {
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService
    private var crypto = CryptoManager()
    
    func fetchAll() async throws -> [AccountInfoWrapper] {
        let accounts = try await accountService.fetchAll()
        let socialAccounts = try await socialAccountService.fetchAll()
        
        let merged = accounts.map(AccountInfoWrapper.account)
                 + socialAccounts.map(AccountInfoWrapper.social)

        return merged.sorted {
            $0.sitename.localizedCaseInsensitiveCompare($1.sitename) == .orderedAscending
        }
    }
    
    func getWrappers(defaultDTOs: [AccountDTO], socialDTOs: [SocialAccountDTO]) -> [AccountInfoWrapper] {
        // 1) DTO -> 엔티티 (실패는 건너뛰기)
        let accounts: [Account] = defaultDTOs.compactMap { try? $0.toEntity(using: crypto) }
        let socialAccounts: [SocialAccount] = socialDTOs.compactMap { try? $0.toEntity(using: crypto) }

        // 2) 엔티티 -> Wrapper
        return accounts.map(AccountInfoWrapper.account)
                + socialAccounts.map(AccountInfoWrapper.social)
    }
}

