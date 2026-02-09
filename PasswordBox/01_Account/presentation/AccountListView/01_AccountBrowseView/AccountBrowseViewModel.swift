//
//  AccountBrowseViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountBrowseViewModel: ObservableObject, @MainActor AccountWrapperBindable, @MainActor ControlMessageBindable {
    @Injected var accountWrapperSubject: CurrentValueSubject<[Account], Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountService: AccountService
    @Injected var accountListSorter: AccountListSorter
    @Injected var accountCache: AccountCache
    @Published var accountWrappers: [Account] = []
    var cancellables: Set<AnyCancellable> = []
    
    init() {        
        setupAccountWrappers()
        setupControlMessageBindable()
    }
                    
    func deleteAccount(offset: IndexSet) {
        // 1) 삭제 대상 요소를 먼저 확보
        let targets: [Account] = offset.compactMap { index in
            guard accountWrappers.indices.contains(index) else { return nil }
            return accountWrappers[index]
        }
        
        // 2) 데이터 소스에서 먼저 삭제
        accountWrappers.remove(atOffsets: offset)
        
        // 3) 실제 서비스 삭제 수행
        for target in targets {
            accountService.delete(target.id)
        }

        Task { [weak self] in
            await self?.accountCache.refresh()
        }
    }
}

extension AccountBrowseViewModel {
    func setupAccountWrappers() {
        bindAccountWrappers{ [weak self] wrappers in
            guard let self else { return }
            self.accountWrappers = wrappers
        }
    }
    
    func setupControlMessageBindable() {
        bindControlMessage { [weak self] message in
            guard let self else { return }
            switch message {
            case .updateSortInfo:
                setAccountWrappers()
            default: break
            }
        }
    }
    
    private func setAccountWrappers() {
        Task { [weak self] in
            guard let self else { return }
            self.accountWrappers = try await self.accountListSorter.sort(accounts: self.accountWrappers)
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
