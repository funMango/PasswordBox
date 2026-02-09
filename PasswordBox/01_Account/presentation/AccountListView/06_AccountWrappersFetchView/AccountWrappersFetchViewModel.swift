//
//  AccountWrappersFetchViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/13/25.
//

import Foundation
import Resolver
import Combine

class AccountWrappersFetchViewModel: ObservableObject, AccountMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var defaultAccountSubject: CurrentValueSubject<[AccountDTO]?, Never>
    @Injected var accountWrapperSubject: CurrentValueSubject<[Account], Never>
    @Injected var userSubject: CurrentValueSubject<UserDTO?, Never>
    @Injected var accountFetcher: AccountFetcher
    @Injected var accountSorter: AccountListSorter
    @Injected var accountCache: AccountCache
    var cancellables = Set<AnyCancellable>()
    
    init() {
        observeSubjects()
        setupAccountMessageBinding()
    }
    
    func pushDefaultAccount(_ account: [AccountDTO]) {
        defaultAccountSubject.send(account)
    }
    
    func pushUser(_ user: [UserDTO]) {
        guard let user = user.first else {
            print(UserError.userNotFound.errorDescription ?? "User Not Found")
            return
        }
        userSubject.send(user)
    }
    
    func fetch() {
        guard
            let defaultAccounts = defaultAccountSubject.value,
            let user = userSubject.value
        else {
            return
        }

        let accounts = getAccounts(
            defaults: defaultAccounts,
            order: user.sortOrder,
            orderBy: user.sortBy
        )
                
        accountWrapperSubject.send(accounts)
    }
    
    private func getAccounts(defaults: [AccountDTO], order: AccountOrder, orderBy: AccountOrderBy) -> [Account] {
        let accounts = accountFetcher.getAccounts(defaultDTOs: defaults)

        let sorted = accountSorter.sort(
            accounts: accounts,
            order: order,
            orderBy: orderBy
        )
        
        Task { [weak self] in
            await self?.accountCache.update(accounts: sorted)
        }
        
        return sorted
    }
}

// Observing
extension AccountWrappersFetchViewModel {
    func observeSubjects() {
        Publishers.CombineLatest(
            defaultAccountSubject,
            userSubject
        )
        .compactMap { defaultAccounts, user -> ([AccountDTO], UserDTO)? in
            guard let da = defaultAccounts, let u = user else { return nil }
            return (da, u)
        }
        .sink { [weak self] defaultAccounts, user in
            guard let self else { return }
            let accounts = getAccounts(
                defaults: defaultAccounts,
                order: user.sortOrder,
                orderBy: user.sortBy
            )
                        
            accountWrapperSubject.send(accounts)
        }
        .store(in: &cancellables)
    }
    
    func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .onRefresh:
                self.fetch()
            default:
                break
            }            
        }
    }
}
