//
//  SocialAccountAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/16/25.
//

import SwiftUI
import Resolver
import Combine


final class SocialAccountAddViewModel: ObservableObject, ControlMessageBindable, AccountMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
        
    @Published var isSiteSearchActive: Bool = false
    @Published var isSocialSearchActive: Bool = false
    
    private var sitename: String = ""
    private var socialSiteName: String = ""
    private var socialAccount: Account?
    var cancellables: Set<AnyCancellable> = []
            
    init() {
        controlMessageBinding()
        accountMessageBinding()
    }
}

// MARK: - Message Binding
extension SocialAccountAddViewModel {
    func controlMessageBinding() {
        bindControlMessage { [weak self] message in
            switch message {
            case .activateSiteTextField:
                self?.isSiteSearchActive.toggle()
            case .activateSocialTextField:                
                self?.isSocialSearchActive.toggle()
            default:
                break
            }
        }
    }
    
    func accountMessageBinding() {
        bindAccountMessage { [weak self] message in
            guard let self else { return }

            switch message {
            case .updateSitename(let sitename):
                self.sitename = sitename
                self.isSiteSearchActive.toggle()
            case .selectSite(let sitename):
                self.socialSiteName = sitename
                self.isSocialSearchActive.toggle()
            case .selectAccount(let account):
                self.socialAccount = account
                self.isSocialSearchActive.toggle()
            default:
                break
            }
        }
    }
}

