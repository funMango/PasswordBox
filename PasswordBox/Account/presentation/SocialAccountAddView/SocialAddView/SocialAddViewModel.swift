//
//  SocialAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//


import Foundation
import Resolver
import Combine

@MainActor
class SocialAddViewModel: ObservableObject, @MainActor AccountMessageBindable, @MainActor SitenameMessageBindable {
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
        setupAccounts()
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
    @MainActor
    func setupAccounts() {
        Task {
            do {
                self.allAccounts = try await accountService.fetchAll()
            } catch(let error) {
                print(error.localizedDescription)
            }
        }
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

