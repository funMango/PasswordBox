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
    @Injected var accountFetcher: AccountFetcher
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var sitenameSubject: CurrentValueSubject<String?, Never>
        
    @Published var text: String = ""
    @Published var allAccountInfo: [AccountInfoWrapper] = []
    @Published var filteredAccounts: [AccountInfoWrapper] = []
    
    var filter: AccountInfoFilter
    
    init(filter: AccountInfoFilter) {
        self.filter = filter
        setupTextBindings()
        setupAllAccounts()
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
    @MainActor
    func setupAllAccounts() {
        Task {
            do {
                self.allAccountInfo = try await accountFetcher.fetchAll()
            } catch(let error) {
                print(error.localizedDescription)
            }
        }        
    }
    
    func setupTextBindings() {
        $text
            .compactMap { $0 }
            .removeDuplicates()
            .combineLatest($allAccountInfo)
            .map { [weak self] query, accounts in
                self?.filter.filtering(
                    accounts: accounts,
                    query: query,
                    excluded: nil
                ) ?? []
            }
            .assign(to: &$filteredAccounts)
    }
}
