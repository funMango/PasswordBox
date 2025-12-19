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
class AccountBrowseViewModel: ObservableObject, @MainActor ControlMessageBindable, @MainActor AccountMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService
    @Published var accountWrappers: [AccountInfoWrapper] = []
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
        setupAccountMessageBinding()
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
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
//            case .updateSortInfo:
//                // self.sortAccountWrappers()
            default:
                return
            }
        }
    }
    
    func setupAccountMessageBinding() {
        bindAccountMessage { [weak self] message in
            guard let self else { return }
            switch message {
            case .fetchWrappers(let wrappers):
                self.accountWrappers = wrappers
            default:
                break
            }
        }
    }
}
