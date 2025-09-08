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
    @Published var text: String = ""
    @Published var allAccounts: [Account] = []
    
    var filteredAccounts: [Account] {
        guard !text.isEmpty else {
            return allAccounts
        }
        
        return allAccounts.filter { account in
            account.siteName.localizedCaseInsensitiveContains(text)
        }
    }
    
    init () {
        fetchAllAccounts()
    }
    
    func createSite() {
        controlSubject.send(.createSite(text))
    }
    
    func fetchAllAccounts() {
        self.allAccounts = accountService.fetchAll()
    }
    
}
