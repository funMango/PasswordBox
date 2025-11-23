//
//  SocialAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//


import Foundation
import Resolver
import Combine

class SocialAddViewModel: ObservableObject, AccountMessageBindable, SitenameMessageBindable {
    @Injected var accountService: AccountService
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var sitenameSubject: CurrentValueSubject<String?, Never>
    
    @Published var text: String = ""
    @Published var sitename: String = ""
    @Published var allAccounts: [Account] = []
    @Published var filteredAccounts: [Account] = []
    
    var filter: AccountFilter
    var cancellables: Set<AnyCancellable> = []
    
    init(filter: AccountFilter) {
        self.filter = filter
        setupSitenameMessageBindings()
        setupTextBindings()
    }
        
    func updateAccount(_ account: Account) {
        accountSubject.send(.selectAccount(account))
    }
    
    func updateSite() {
        accountSubject.send(.selectSite(text))
    }
    
    func reset() {
        sitenameSubject.send(nil)
    }
}

// MARK: - Bindings
extension SocialAddViewModel {
    func setupAccounts() async {
        self.allAccounts = await accountService.fetchAll()
    }
    
    func setupSitenameMessageBindings() {
        bindSitenameMessage{ [weak self] sitename in
            guard let sitename = sitename else { return }
            self?.sitename = sitename
        }
    }
    
    func setupTextBindings() {
        $text
            .removeDuplicates()
            .combineLatest($allAccounts, $sitename)
            .map { [weak self] query, accounts, sitename in
                let filtered = self?.filter.filtering(
                    accounts: accounts,
                    query: query,
                    excluded: sitename
                )
                
                return filtered ?? []
            }
            .assign(to: &$filteredAccounts)
    }
}

