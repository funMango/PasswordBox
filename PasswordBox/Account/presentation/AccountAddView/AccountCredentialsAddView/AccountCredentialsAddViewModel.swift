//
//  PasswordAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation
import Resolver
import Combine

class AccountCredentialsAddViewModel: ObservableObject, AccountMessageBindable {
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var credentials = AccountCredentials()
    var cancellables: Set<AnyCancellable> = []
            
    init() {
        setupBindings()
    }
    
    func setupBindings() {
        $credentials
            .dropFirst() // 초기값은 무시
            .sink { [weak self] cred in
                self?.accountSubject.send(.updateAccountCredentials(cred))
            }
            .store(in: &cancellables)
    }
}

