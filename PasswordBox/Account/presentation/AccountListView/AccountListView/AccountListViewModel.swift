//
//  SiteListViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver
import Combine

class AccountListViewModel: ObservableObject, AccountMessageBindable {
    @Injected var accountService: AccountService
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var accounts: [Account] = []
    @Published var searchText: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    var filteredSites: [Account] {
        guard !searchText.isEmpty else {
            return accounts
        }
        
        return accounts.filter { site in
            site.sitename.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    init() {
        setupAccountMessageBinding()
    }
    
    func fetchAccounts() {
        self.accounts = accountService.fetchAll()
    }
                    
    func deleteAccount(offset: IndexSet) {
        for index in offset {
            let siteIdToDelete = accounts[index].id
            accountService.delete(siteIdToDelete)
        }
    }
    
    func setupAccountMessageBinding() {
        bindAccountMessage{ message in
            switch message {
            case .changeSearchText(let newText):
                DispatchQueue.main.async {
                    self.searchText = newText
                }
            default:
                return
            }
            
        }
    }
}
