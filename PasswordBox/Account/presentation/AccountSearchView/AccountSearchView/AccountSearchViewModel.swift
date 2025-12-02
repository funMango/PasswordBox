//
//  AccountSearchViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 11/26/25.
//

import Foundation
import Resolver
import Combine

class AccountSearchViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountFetcher: AccountFetcher
    @Injected var accountSorter: AccountListSorter
    @Published var accountWrappers: [AccountInfoWrapper] = []
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        Task { await fetchAccounts() }
    }
    
    @MainActor
    func fetchAccounts() async {
        let wrappers = await accountFetcher.fetchAll()
        self.accountWrappers = accountSorter.sort(
            wrappers: wrappers,
            orderBy: .title,
            order: .ascending
        )
    }
}
