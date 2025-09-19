//
//  SocialAccountSelectedViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import Foundation
import Resolver
import Combine

class SocialAccountSelectedViewModel: ObservableObject, AccountMessageBindable {
    @Injected var accountSubject : PassthroughSubject<AccountMessage, Never>
    
    @Published var selectedSite: String?
    @Published var selectedAccount: Account?
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupAccountMessageBinding()
    }
    
    func delteSite() {
        self.selectedSite = nil
    }
    
    func deleteAccount() {
        self.selectedAccount = nil
    }
    
    private func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .selectSite(let site):
                self?.selectedSite = site
                self?.selectedAccount = nil
            case .selectAccount(let account):
                print("Account 수신")
                self?.selectedAccount = account
                self?.selectedSite = nil
            default:
                return
            }
        }
    }
}
