//
//  SiteAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import Foundation
import Resolver
import Combine

class SiteAddViewModel: ObservableObject {
    @Injected var accountService: AccountService
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var text: String = ""
    @Published var allAccounts: [Account] = []
    
    var filteredAccounts: [Account] {
        guard !text.isEmpty else {
            return allAccounts
        }
        
        return allAccounts.filter { account in
            account.sitename.localizedCaseInsensitiveContains(text)
        }
    }
    
    init () {
        fetchAllAccounts()
    }
    
    func updateSite() {
        accountSubject.send(.updateSitename(text))
    }
    
    func fetchAllAccounts() {
        self.allAccounts = accountService.fetchAll()
    }
    
}
