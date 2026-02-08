//
//  PasswordAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountCredentialsAddViewModel: ObservableObject, @MainActor AccountMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var credentials = AccountCredentials()
    
    var cancellables: Set<AnyCancellable> = []
            
    init() {
        setupBindings()
        setupAccountMessageBinding()
    }
    
    func setupBindings() {
        $credentials
            .dropFirst()
            .sink { [weak self] cred in
                self?.accountSubject.send(.updateAccountCredentials(cred))
            }
            .store(in: &cancellables)
    }
}

extension AccountCredentialsAddViewModel {
    private func setupAccountMessageBinding() {
        bindAccountMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .updateSitename(let sitename):
                self.credentials.set(sitename: sitename)
            case .updateSocialId(let socialId):
                self.credentials.set(socialId: socialId)
            default:
                return
            }
        }
    }
}


