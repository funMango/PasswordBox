//
//  SiteListViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import SwiftUI
import Resolver
import Combine

@MainActor
class AccountListViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var type: SearchType = .normal
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()        
    }
                
    func onTapAccountCell() {
        controlSubject.send(.deFocusSearchBar)
    }
}

// MARK: - Combine binding
extension AccountListViewModel {
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchType(let type):
                self.type = type
            default: return
            }
        }
    }
}

