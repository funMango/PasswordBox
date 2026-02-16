//
//  SiteAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import Combine

class AccountAddViewModel: ObservableObject, ControlMessageBindable, AccountMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var AccountService: AccountService
    @Injected var accountCache: AccountCache
        
    @Published var isSiteSearchActive: Bool = false
    @Published var isSocialSearchActive: Bool = false
    @Published var accountCredentials: AccountCredentials?
    
    var cancellables: Set<AnyCancellable> = []
            
    init() {
        setupControlMessageBinding()
        setupAccountMessageBinding()
    }
    
    @MainActor
    func saveAccount() {
        guard let accountCredentials = accountCredentials else {
            print("saveAccount: ⚠️ accountCredntials is nil")
            return
        }
        
        let request = CreateAccountRequest(
            sitename: accountCredentials.sitename,
            username: accountCredentials.username,
            password: accountCredentials.password,
            pin: accountCredentials.pin,
            memo: accountCredentials.memo,
            socialId: accountCredentials.socialId
        )
        
        AccountService.save(request)
        Task { [weak self] in
            await self?.accountCache.refresh()
        }
        deactivatePage()
    }
    
    private func deactivatePage() {
        reset()
        controlSubject.send(.hideAccountAddSheet)
    }
    
    private func reset() {
        self.accountCredentials = nil
    }
}

// MARK: - Validate
extension AccountAddViewModel {
    var canSave: Bool {
        guard let cred = accountCredentials else {
            print("canSave: ⚠️ accountCredntials is nil")
            return false
        }
        
        return !cred.sitename.isEmpty
    }
}

// MARK: - Combine
extension AccountAddViewModel {
    private func setupControlMessageBinding() {
        bindControlMessage { [weak self] message in
            switch message {
            case .activateSiteTextField:
                self?.isSiteSearchActive = true
            case .activateSocialTextField:
                self?.isSocialSearchActive = true
            default:
                return
            }
        }
    }
    
    private func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .updateSitename:
                self?.isSiteSearchActive.toggle()
            case .updateSocialId:                
                self?.isSocialSearchActive.toggle()
            case .updateAccountCredentials(let cred):
                self?.accountCredentials = cred
            default:
                return
            }
        }
    }
    
    
    
    
}
