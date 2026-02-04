//
//  AccountListToolbarTitleViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 12/10/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountListToolbarTitleViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var showToolbarTitle: Bool = false
    @Published var title: String = String(localized: "account")
    @Published var state: SearchType = .normal
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
    }
    
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .toolbarTitleAppear:
                self.showToolbarTitle = true
            case .toolbarTitleDisappear:
                self.showToolbarTitle = false
            case .changeSearchType(let type):
                self.state = type
            default:
                break
            }
        }
    }
}

