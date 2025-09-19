//
//  SiteAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class SiteAddViewModel: ObservableObject {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published private(set) var controller = AccountListController()

    var text: String {
        get { controller.text }
        set { controller.text = newValue }
    }
    
    var filteredAccounts: [Account] { controller.filteredAccounts }
    
    func setSite(from sitename: String) {
        self.text = sitename
        updateSite()
    }
    
    func updateSite() {
        accountSubject.send(.updateSitename(text))
    }
}
