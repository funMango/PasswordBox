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
    @Injected var accountListSorter: AccountListSorter
    @Injected var socialAccountService: SocialAccountService
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    
    @Published var accountWrappers: [AccountInfoWrapper] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private var currentOrder: AccountOrder?
    private var currentOrderBy: AccountOrderBy?
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupAccountMessageBinding()
        setupControlMessageBinding()
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
    
    private func applySort(order: AccountOrder, orderBy: AccountOrderBy) {        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.accountWrappers = self.accountListSorter.sort(
                wrappers: self.accountWrappers,
                orderBy: orderBy,
                order: order
            )
        }
    }
}

