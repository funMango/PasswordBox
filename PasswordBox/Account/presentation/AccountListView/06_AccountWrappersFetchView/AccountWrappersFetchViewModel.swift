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
    @Injected var socialAccountSubject: CurrentValueSubject<[SocialAccountDTO]?, Never>
    @Injected var userSubject: CurrentValueSubject<UserDTO?, Never>
    @Injected var accountFetcher: AccountFetcher
    @Injected var accountSorter: AccountListSorter
    var cancellables = Set<AnyCancellable>()
    
    init() {
        observeSubjects()
        setupAccountMessageBinding()
    }
    
    func pushDefaultAccount(_ account: [AccountDTO]) {
        defaultAccountSubject.send(account)
    }
    
    func pushSocialAccount(_ account: [SocialAccountDTO]) {
        socialAccountSubject.send(account)
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
            let socialAccounts = socialAccountSubject.value,
            let user = userSubject.value
        else {
            return
        }

        let wrappers = getWrappers(
            defaults: defaultAccounts,
            socials: socialAccounts,
            order: user.sortOrder,
            orderBy: user.sortBy
        )
        
        accountSubject.send(.fetchWrappers(wrappers))
    }
    
    private func getWrappers(defaults: [AccountDTO], socials: [SocialAccountDTO], order: AccountOrder, orderBy: AccountOrderBy) -> [AccountInfoWrapper] {
        
        let wrappers = accountFetcher.getWrappers(
            defaultDTOs: defaults,
            socialDTOs: socials
        )

        let sorted = accountSorter.sort(
            wrappers: wrappers,
            order: order,
            orderBy: orderBy
        )
        
        return sorted
    }
}

// Observing
extension AccountWrappersFetchViewModel {
    func observeSubjects() {
        Publishers.CombineLatest3(
            defaultAccountSubject,
            socialAccountSubject,
            userSubject
        )
        .compactMap { defaultAccounts, socialAccounts, user -> ([AccountDTO], [SocialAccountDTO], UserDTO)? in
            guard let da = defaultAccounts, let sa = socialAccounts, let u = user else { return nil }
            return (da, sa, u)
        }
        .sink { [weak self] defaultAccounts, socialAccounts, user in
            guard let self else { return }
            let wrappers = getWrappers(
                defaults: defaultAccounts,
                socials: socialAccounts,
                order: user.sortOrder,
                orderBy: user.sortBy
            )
            
            accountSubject.send(.fetchWrappers(wrappers))
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
