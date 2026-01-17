//
//  AccountSearchViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountSearchViewModel: ObservableObject, @MainActor AccountMessageBindable, @MainActor AccountWrapperBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var accountWrapperSubject: CurrentValueSubject<[AccountInfoWrapper], Never>
    @Published var searchText: String = ""
    @Published var accountWrappers: [AccountInfoWrapper] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupAccountMessageBindable()
        setupAccountWrappers()
    }
}

extension AccountSearchViewModel {
    func setupAccountMessageBindable() {
        bindAccountMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchText(let text):
                self.searchText = text
            case .fetchWrappers(let wrappers):
                self.accountWrappers = wrappers
            default: break
            }
        }
    }
    
    func setupAccountWrappers() {
        bindAccountWrappers{ [weak self] wrappers in            
            guard let self else { return }
            self.accountWrappers = wrappers
        }
    }
}
