//
//  SiteListViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver
import Combine

class AccountListViewModel: ObservableObject, AccountMessageBindable, ControlMessageBindable {
    @Injected var accountService: AccountService
    @Injected var accoutFetcher: AccountFetcher
    @Injected var socialAccountService: SocialAccountService
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    @Published var accounts: [Account] = []
    @Published var accountWrappers: [AccountInfoWrapper] = []
    @Published var searchText: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchAccountWrappers()
        setupAccountMessageBinding()
        setupControlMessageBinding()
    }
    
    func fetchAccountWrappers() {
        self.accountWrappers = accoutFetcher.fetchAll()
    }
                    
    func deleteAccount(offset: IndexSet) {
        for index in offset {
            switch accountWrappers[index] {
            case .account(let acc):
                accountService.delete(acc.id)
            case .social(let soc):
                socialAccountService.delete(id: soc.id)
            }
        }
    }
}

// MARK: - Combine binding
extension AccountListViewModel {
    func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .changeSearchText(let newText):
                DispatchQueue.main.async {
                    self?.searchText = newText
                }
            case .sortByTitle:
                print("sortByTitle")
            default:
                return
            }
        }
    }
    
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            switch message {
            case .syncIcloud:
                self?.fetchAccountWrappers()
            default:
                return
            }
            
        }
    }
}
