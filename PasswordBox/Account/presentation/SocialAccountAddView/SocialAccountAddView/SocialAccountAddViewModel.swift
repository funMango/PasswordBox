//
//  SocialAccountAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import SwiftUI
import Resolver
import Combine

@MainActor
final class SocialAccountAddViewModel: ObservableObject {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    
    @Published private(set) var controller = AccountListController()
    
    var filteredAccounts: [Account] { controller.filteredAccounts }
    var cancellables: Set<AnyCancellable> = []
    
    var text: String {
        get { controller.text }
        set { controller.text = newValue }
    }
        
    func updateSite() {
        withAnimation(.easeInOut) {
            accountSubject.send(.selectSite(text))
        }
    }
    
    func updateAccount(from account: Account){
        withAnimation(.easeInOut) {
            accountSubject.send(.selectAccount(account))
        }
    }
}

