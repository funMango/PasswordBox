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
    
    private var currentOrder: AccountOrder = .ascending
    private var currentOrderBy: AccountOrderBy = .title
    var cancellables: Set<AnyCancellable> = []
    
    init() {        
        setupAccountMessageBinding()
        setupControlMessageBinding()
    }
    
    func fetchAccountWrappers() async {        
        // 1) 백그라운드에서 fetch + sort 모두 처리
        let fetched = await accoutFetcher.fetchAll()
        let sorted = accountListSorter.sort(
            wrappers: fetched,
            orderBy: currentOrderBy,
            order: currentOrder
        )
        
        // 2) 메인에서는 최종값만 한 번에 반영
        await MainActor.run {
            self.accountWrappers = sorted
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
