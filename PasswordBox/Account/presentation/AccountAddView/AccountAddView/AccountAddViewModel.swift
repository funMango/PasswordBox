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
        
    @Published var isSiteSearchActive: Bool = false
    @Published var accountCredentials: AccountCredentials?
    @Published var sitename: String = ""
    
    var cancellables: Set<AnyCancellable> = []
            
    init() {
        setupControlMessageBinding()
        setupAccountMessageBinding()
    }
                    
    func saveAccount() {
        guard let accountCredentials = accountCredentials else {
            print("saveAccount: ⚠️ accountCredntials is nil")
            return
        }
        
        let request = CreateAccountRequest(
            sitename: sitename,
            username: accountCredentials.username,
            password: accountCredentials.password,
            pin: accountCredentials.pin,
            memo: accountCredentials.memo
        )
        
        AccountService.save(request)
        deactivatePage()
    }
    
    private func deactivatePage() {
        reset()
        controlSubject.send(.toggleIsShowingAccountAddSheet)
    }
    
    private func reset() {
        self.sitename = ""
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
        
        if sitename.isEmpty || cred.username.isEmpty || cred.password.isEmpty {
            return false
        }
                
        return true
    }
}

// MARK: - Combine
extension AccountAddViewModel {
    private func setupControlMessageBinding() {
        bindControlMessage { [weak self] message in
            switch message {
            case .activateSiteTextField:
                self?.isSiteSearchActive = true                           
            default:
                return
            }
        }
    }
    
    private func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .updateSitename(let sitename):
                self?.sitename = sitename
                self?.isSiteSearchActive.toggle()
            case .updateAccountCredentials(let cred):
                self?.accountCredentials = cred
            default:
                return
            }
        }
    }
}
