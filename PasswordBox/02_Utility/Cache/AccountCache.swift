//
//  AccountCache.swift
//  PasswordBox
//
//  Created by Codex on 2/8/26.
//

import Foundation
import Resolver

final class AccountCache {
    @Injected var accountService: AccountService
    private var sitenameById: [String: String] = [:]
    private var hasLoaded: Bool = false
    
    @MainActor
    func update(accounts: [Account]) {
        sitenameById = Dictionary(uniqueKeysWithValues: accounts.map { ($0.id, $0.sitename) })
        hasLoaded = true
    }
    
    @MainActor
    func sitename(for id: String) -> String? {
        sitenameById[id]
    }
    
    @MainActor
    func ensureLoaded() async {
        if hasLoaded { return }
        await refresh()
    }
    
    @MainActor
    func refresh() async {
        do {
            let accounts = try await accountService.fetchAll()
            update(accounts: accounts)
        } catch {
            print(error.localizedDescription)
        }
    }
}
