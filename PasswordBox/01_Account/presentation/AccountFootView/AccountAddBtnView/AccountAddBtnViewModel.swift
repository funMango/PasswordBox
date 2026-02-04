//
//  SiteAddBtnViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI
import Foundation
import Resolver
import Combine

@MainActor
class AccountAddBtnViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>    
    @Published var type: SearchType = .normal
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
    }
        
    func toggleIsShowingAccountAddSheet() {
        controlSubject.send(.toggleIsShowingAccountAddSheet)
    }
    
    func tappedCloseButton() {
        controlSubject.send(.changeSearchType(.normal))
    }
}

extension AccountAddBtnViewModel {
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
