//
//  AccountFetcher.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation
import Resolver

protocol AccountFetcher {
    func fetchAll() async throws -> [Account]
    func getAccounts(defaultDTOs: [AccountDTO]) -> [Account]
}

final class DefaultAccountFetcher: AccountFetcher {
    @Injected var accountService: AccountService
    private var crypto = CryptoManager()
    
    func fetchAll() async throws -> [Account] {
        let accounts = try await accountService.fetchAll()
        return accounts.sorted {
            $0.sitename.localizedCaseInsensitiveCompare($1.sitename) == .orderedAscending
        }
    }
    
    func getAccounts(defaultDTOs: [AccountDTO]) -> [Account] {
        // 1) DTO -> 엔티티 (실패는 건너뛰기)
        let accounts: [Account] = defaultDTOs.compactMap { try? $0.toEntity(using: crypto) }

        // 2) 엔티티 반환
        return accounts
    }
}
