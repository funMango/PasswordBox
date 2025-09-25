//
//  AccountListController.swift
//  PasswordBox
//
//  Created by 이민호 on 9/18/25.
//

import Foundation
import Resolver
import Combine

enum AccountFilterType {
    case sitename
    case sitenameOrUsername
}

@MainActor
final class AccountListController: ObservableObject {
    @Injected var accountService: AccountService

    @Published var text: String = ""
    @Published var type: AccountFilterType = .sitename
    @Published private(set) var allAccounts: [Account] = []
    @Published private(set) var filteredAccounts: [Account] = []

    private var cancellables: Set<AnyCancellable> = []

    init(type: AccountFilterType = .sitename) {
        self.type = type
        
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
            .combineLatest($allAccounts, $type)
            .map { query, accounts, type in
                guard !query.isEmpty else { return accounts }
                switch type {
                case .sitename:
                    return accounts.filtered(query: query)
                case .sitenameOrUsername:
                    return accounts.filtered(type: .sitenameOrUsername, query: query)
                }
            }
            .assign(to: &$filteredAccounts)
    }
}
