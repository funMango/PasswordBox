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
    @Published var sitename: String = ""
    @Published var account: Account?
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        accountMessageBinding()
    }
            
    func sendMessage(){
        controlSubject.send(.activateSocialTextField)
    }
}

extension SocialTextFieldViewModel {
    func accountMessageBinding() {
        bindAccountMessage { message in
            switch message {
            case .selectSite(let sitename):
                self.sitename = sitename
                self.account = nil
            case .selectAccount(let account):
                self.account = account
                self.sitename = ""
            default:
                break
            }
        }
    }
}

