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
    @Injected var accountWrapperSubject: CurrentValueSubject<[AccountInfoWrapper], Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountService: AccountService
    @Injected var accountListSorter: AccountListSorter
    @Injected var socialAccountService: SocialAccountService
    @Published var accountWrappers: [AccountInfoWrapper] = []
    var cancellables: Set<AnyCancellable> = []
    
    init() {        
        setupAccountWrappers()
        setupControlMessageBindable()
    }
                    
    func deleteAccount(offset: IndexSet) {
        // 1) 삭제 대상 요소를 먼저 확보
        let targets: [AccountInfoWrapper] = offset.compactMap { index in
            guard accountWrappers.indices.contains(index) else { return nil }
            return accountWrappers[index]
        }
        
        // 2) 데이터 소스에서 먼저 삭제
        accountWrappers.remove(atOffsets: offset)
        
        // 3) 실제 서비스 삭제 수행
        for target in targets {
            switch target {
            case .account(let acc):
                accountService.delete(acc.id)
            case .social(let soc):
                socialAccountService.delete(id: soc.id)
            }
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
                print("received updateSortInfo message.")
                setAccountWrappers()
            default: break
            }
        }
    }
    
    private func setAccountWrappers() {
        Task { [weak self] in
            guard let self else { return }
            self.accountWrappers = try await self.accountListSorter.sort(wrappers: self.accountWrappers)
        }
    }
}
