//
//  AccountFooterViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI
import Resolver
import Combine

@MainActor
class AccountFootViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var type: SearchType = .normal
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
    }
}

extension AccountFootViewModel {
    func setupControlMessageBinding() {
        bindControlMessage() { [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchType(let type):
                withAnimation {                    
                    self.type = type
                }
            default: break
            }
        }
    }
}
