//
//  SiteTextFieldViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import Foundation
import Resolver
import Combine

class SiteTextFieldViewModel: ObservableObject, AccountMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var siteName: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupAccountMessageBinding()
    }
            
    func sendControlMessage() {
        controlSubject.send(.activateSiteTextField)
    }
    
    func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            switch message {
            case .updateSitename(let sitename):
                self?.siteName = sitename
            default:
                break
            }
        }
    }
}


