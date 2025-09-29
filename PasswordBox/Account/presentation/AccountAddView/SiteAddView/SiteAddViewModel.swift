//
//  SiteAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class SiteAddViewModel: ObservableObject {
    @Injected var accountService: AccountService
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var sitenameSubject: CurrentValueSubject<String?, Never>
    
    @Published var text: String = ""
    @Published var allAccounts: [Account] = []
    @Published var filteredAccounts: [Account] = []
    
    var filter: AccountFilter
    
    init(filter: AccountFilter) {
        self.filter = filter
        
        setupAccounts()
        setupTextBindings()
    }
    
    func setSite(from sitename: String) {
        self.text = sitename
        updateSite()
    }
    
    func updateSite() {
        accountSubject.send(.updateSitename(text))
        sitenameSubject.send(text)
    }
}

extension SiteAddViewModel {
    func setupAccounts() {
        self.allAccounts = accountService.fetchAll()
    }
    
    func setupTextBindings() {
        $text
            .compactMap { $0 }
            .removeDuplicates()
            .combineLatest($allAccounts)
            .map { [weak self] query, accounts in
                self?.filter.filtering(
                    accounts: accounts,
                    query: query, excluded: nil
                ) ?? []
            }
            .assign(to: &$filteredAccounts)
    }
}
