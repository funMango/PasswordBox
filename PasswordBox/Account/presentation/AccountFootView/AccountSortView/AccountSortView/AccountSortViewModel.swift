//
//  SiteSortBtnViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountSortViewModel: ObservableObject, @MainActor AccountMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var userService: UserService
    @Published var orderBy: AccountOrderBy = .title
    @Published var order: AccountOrder = .ascending
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupAccountMessageBinding()
        bindingOrderBy()
        bindingOrder()
    }
    
    func updateOrderBy(_ orderBy: AccountOrderBy) {
        try? userService.update(option: orderBy)
    }
}

extension AccountSortViewModel {
    private func bindingOrderBy() {
        $orderBy
            .dropFirst() /// 처음 초기화 되는 값(.title)이 클라우드에 저장되는 것을 막기위해 사용한다.
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self else { return }
                try? userService.update(option: newValue)
                accountSubject.send(.updateSortBy(order, newValue))
            }
            .store(in: &cancellables)
    }
    
    private func bindingOrder() {
        $order
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self else { return }
                try? userService.update(option: newValue)
                accountSubject.send(.updateSortBy(newValue, orderBy))
            }
            .store(in: &cancellables)
    }
    
    private func setupAccountMessageBinding() {
        bindAccountMessage { [weak self] message in
            guard let self else { return }
            switch message {
                                        
            /// setter message
            case .setOrder(let order):
                self.order = order
            case .setOrderBy(let orderBy):
                self.orderBy = orderBy
            default:
                return
            }
        }
    }
}
