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
    /// usecase
    @Injected var accountService: AccountService
    @Injected var socialAccountService: SocialAccountService
    
    /// controller
    @Injected var accoutFetcher: AccountFetcher
    @Injected var accountListSorter: AccountListSorter
    @Injected var accountFilter: AccountSearchFilter
    
    /// subject
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    @Published var accountWrappers: [AccountInfoWrapper] = []
    @Published var searchedWrappers: [AccountInfoWrapper] = []
    @Published var searchTypeManager: SearchTypeManager = Resolver.resolve()
    @Published var router: Router = Resolver.resolve()
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false    
    
    private var currentOrder: AccountOrder?
    private var currentOrderBy: AccountOrderBy?    
    var cancellables: Set<AnyCancellable> = []
    var displayedWrappers: [AccountInfoWrapper] {
        switch searchTypeManager.type {
        case .normal:
            return accountWrappers
        case .search:
            return searchedWrappers
        }
    }
    
    init() {
        Task { await fetchAccountWrappers() }
        setupAccountMessageBinding()
        setupControlMessageBinding()
        setupStateBinding()
        setupSearchTextBinding()        
    }
    
    @MainActor
    func fetchAccountWrappers() async {
        guard let currentOrderBy, let currentOrder else {
            return
        }
                
        self.isLoading = true                                        
        let fetched = await accoutFetcher.fetchAll()
        let sorted = accountListSorter.sort(
            wrappers: fetched,
            orderBy: currentOrderBy,
            order: currentOrder
        )
                
        await MainActor.run {
            self.accountWrappers = sorted            
            isLoading = false
        }
    }
    
    @MainActor
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
    func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .changeSearchText(let newText):
                DispatchQueue.main.async {
                    self?.searchText = newText
                }
            case .updateSortBy(let order, let orderBy):
                self?.currentOrder = order
                self?.currentOrderBy = orderBy
                Task { [weak self] in
                    await self?.fetchAccountWrappers()
                }
            default:
                return
            }
        }
    }
    
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            switch message {            
            case .syncIcloud:
                Task { [weak self] in
                    await self?.fetchAccountWrappers()
                }
            default:
                return
            }
        }
    }
    
    func setupStateBinding() {
        searchTypeManager.$type
            .removeDuplicates()
            .sink { [weak self] state in
                switch state {
                case .search:
                    self?.searchedWrappers = self?.accountWrappers ?? []
                default:
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    func setupSearchTextBinding() {
        $searchText
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                self.searchedWrappers = self.accountFilter.filter(
                    accounts: self.accountWrappers,
                    query: text
                )
            }
            .store(in: &cancellables)
    }
}

