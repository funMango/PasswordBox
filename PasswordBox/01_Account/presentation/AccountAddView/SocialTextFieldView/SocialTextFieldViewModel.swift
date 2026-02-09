//
//  SocialTextFieldViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/20/25.
//

import Foundation
import Resolver
import Combine

class SocialTextFieldViewModel: ObservableObject, AccountMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountCache: AccountCache
    @Published var sitename: String = ""
    @Published var account: Account?
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        Task { [weak self] in
            await self?.accountCache.ensureLoaded()
        }
        accountMessageBinding()
    }
            
    func sendMessage(){
        controlSubject.send(.activateSocialTextField)
    }
    
    @MainActor
    func fallbackSitename(for account: Account) -> String? {
        guard let id = account.socialId else { return nil }
        return accountCache.sitename(for: id)
    }
    
    func accountMessageBinding() {
        bindAccountMessage { message in
            switch message {
            case .selectAccount(let account):
                self.account = account
                self.sitename = account.sitename
            default:
                break
            }
        }
    }
}
