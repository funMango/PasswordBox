//
//  AccountListController.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation
import Resolver
import Combine

@MainActor
final class AccountListController: ObservableObject {
    @Injected var accountService: AccountService

    @Published var text: String = ""
    @Published private(set) var allAccounts: [Account] = []
    @Published private(set) var filteredAccounts: [Account] = []

    private var cancellables: Set<AnyCancellable> = []

    init() {        
        setupBindings()
        Task { [weak self] in
            await self?.reload()
        }
    }

    func reload() async {
        allAccounts = await accountService.fetchAllAsync()
    }

    private func setupBindings() {
        $text
            .removeDuplicates()
            .combineLatest($allAccounts)
            .map { query, accounts in
                accounts.filtered(by: query)
            }
            .assign(to: &$filteredAccounts)
    }
}
