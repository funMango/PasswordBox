//
//  SocialAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//


import Foundation
import Resolver
import Combine

@MainActor
class SocialAddViewModel: ObservableObject {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published private(set) var controller = AccountListController(type: .sitenameOrUsername)
    
    var text: String {
        get { controller.text }
        set { controller.text = newValue }
    }
    
    var filteredAccounts: [Account] { controller.filteredAccounts }
    
    func updateAccount(_ account: Account) {
        accountSubject.send(.selectAccount(account))
    }
    
    func updateSite() {
        accountSubject.send(.selectSite(text))
    }
}

