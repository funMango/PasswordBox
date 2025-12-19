//
//  SiteListViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import SwiftUI
import Resolver
import Combine

enum AccountListState {
    case list
    case search
    case loading
    case error
    case cloudError
}

@MainActor
class AccountListViewModel: ObservableObject, @MainActor AccountMessageBindable, @MainActor ControlMessageBindable {
    /// usecase
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService    
    @Injected var accountFilter: AccountSearchFilter
    
    /// subject
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    @Published var accountWrappers: [AccountInfoWrapper] = []
    @Published var searchedWrappers: [AccountInfoWrapper] = []    
    @Published var state: AccountListState = .list
    var cancellables: Set<AnyCancellable> = []
    var displayedWrappers: [AccountInfoWrapper] {
        switch state {
        case .list:
            return accountWrappers
        case .search:
            return searchedWrappers
        default:
            return []
        }
    }
    
    init() {
        setupAccountMessageBinding()
        setupControlMessageBinding()        
    }
    
    func onRefresh() {
        accountSubject.send(.onRefresh)
    }
                
    func onTapAccountCell() {
        controlSubject.send(.deFocusSearchBar)
    }
}

// MARK: - Combine binding
extension AccountListViewModel {
    func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .changeSearchText(let newText):
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.searchedWrappers = self.accountFilter.filter(
                        accounts: self.accountWrappers,
                        query: newText
                    )
                }
            default:
                return
            }
        }
    }
        
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchType(let type):
                self.changeState(type)
            default:
                return
            }
        }
    }
    
    private func changeState(_ type: SearchType) {
        switch type {
        case .normal:
            withAnimation(.easeInOut(duration: 0.3)) {
                self.state = .list
            }
        case .search:
            withAnimation(.easeInOut(duration: 0.3)) {
                self.state = .search
            }
        }
    }
}

