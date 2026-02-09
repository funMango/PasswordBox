//
//  AccountSearchViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountSearchViewModel: ObservableObject, @MainActor AccountMessageBindable, @MainActor AccountWrapperBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var accountWrapperSubject: CurrentValueSubject<[Account], Never>
    @Injected var accountFilter: AccountSearchFilter
    @Injected var accountCache: AccountCache
    @Published var accountWrappers: [Account] = []
    @Published var displayWrappers: [Account] = []
    @Published var query: String = ""
    var cancellables = Set<AnyCancellable>()
    
    init() {
        Task { [weak self] in
            await self?.accountCache.ensureLoaded()
        }
        setupAccountMessageBindable()
        setupAccountWrappers()
    }
}

extension AccountSearchViewModel {
    func setupAccountMessageBindable() {
        bindAccountMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchText(let text):
                filterWrappersByQuery(query: text)
            default: break
            }
        }
    }
    
    func filterWrappersByQuery(query: String) {
        self.query = query
        
        if query.isEmpty {
            self.displayWrappers = accountFilter.filterByDate(accounts: accountWrappers)
            return
        }
            
        self.displayWrappers = accountFilter.filter(accounts: accountWrappers, query: query)        
    }
    
    func setupAccountWrappers() {
        bindAccountWrappers{ [weak self] wrappers in            
            guard let self else { return }
            self.accountWrappers = wrappers
            self.displayWrappers = accountFilter.filterByDate(accounts: accountWrappers)
        }
    }

    @MainActor
    func displaySubtitle(for account: Account) -> (text: String, usesFallback: Bool) {
        if account.username.isEmpty, let id = account.socialId, let sitename = accountCache.sitename(for: id) {
            return (sitename, true)
        }
        return (account.username, false)
    }
}
