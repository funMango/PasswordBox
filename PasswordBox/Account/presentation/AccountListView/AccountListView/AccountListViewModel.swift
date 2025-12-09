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
    @Injected var accountFetcher: AccountFetcher
    @Injected var accountListSorter: AccountListSorter
    @Injected var accountFilter: AccountSearchFilter
    
    /// subject
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    @Published var accountWrappers: [AccountInfoWrapper] = []
    @Published var searchedWrappers: [AccountInfoWrapper] = []    
    @Published var state: AccountListState = .loading
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
        setupCloudMessageBinding()
    }
        
    func fetchAccountWrappers() {
        self.state = .loading
        
        Task {
            do {
                let wrappers = try await accountFetcher.fetchAll()
                let sorted = try await accountListSorter.sort(wrappers: wrappers)
                self.accountWrappers = sorted
                self.state = .list
            } catch {
                self.state = .error
            }
        }
    }
    
    
    func sortAccountWrappers() {
        Task {
            do {
                let sorted = try await accountListSorter.sort(wrappers: self.accountWrappers)
                self.accountWrappers = sorted
            } catch {
                self.state = .error
            }
        }
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
    
    func onTapAccountCell() {
        controlSubject.send(.deFocusSearchBar)
    }
}

// MARK: - Combine binding
extension AccountListViewModel {
    func setupCloudMessageBinding() {
        bindControlMessage { [weak self] message in
            guard let self else { return }
            switch message {
            case .connectingCloud:
                self.state = .loading
            case .cloudConnected:
                self.fetchAccountWrappers()
            case .cloudConnectionFailed:
                self.state = .cloudError
            default:
                break
            }            
        }
    }
        
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
            case .updateSortInfo:
                self.sortAccountWrappers()
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

