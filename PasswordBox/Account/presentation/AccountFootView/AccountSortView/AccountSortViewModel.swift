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
class AccountSortViewModel: ObservableObject, @MainActor AccountMessageBindable,
    @MainActor ControlMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var userService: UserService
    @Published var orderBy: AccountOrderBy = .title
    @Published var order: AccountOrder = .ascending
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
        bindingOrderBy()
        bindingOrder()
    }
    
    func setOrderAndOrderBy() {
        Task {
            let (order, orderBy) = try await userService.getOrderAndOrderBy()
            self.order = order
            self.orderBy = orderBy
        }
    }
}

extension AccountSortViewModel {
    private func bindingOrderBy() {
        $orderBy
            .dropFirst() /// 처음 초기화 되는 값(.title)이 클라우드에 저장되는 것을 막기위해 사용한다.
            .removeDuplicates()
            .sink { [weak self] newOrderBy in
                guard let self else { return }
                Task {
                    do {
                        try await self.userService.update(option: newOrderBy)
                        self.controlSubject.send(.updateSortInfo)
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func bindingOrder() {
        $order
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] newOrder in
                guard let self else { return }
                Task {
                    do {
                        try await self.userService.update(option: newOrder)
                        self.controlSubject.send(.updateSortInfo)
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .cloudConnected:
                self.setOrderAndOrderBy()
            default:
                break
            }
            
        }
    }
}
