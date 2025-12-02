//
//  AccountListStateManager.swift
//  PasswordBox
//
//  Created by 이민호 on 11/29/25.
//

import SwiftUI
import Resolver
import Combine

class SearchTypeManager: ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var type: SearchType = .normal
    var cancellables: Set<AnyCancellable> = []
        
    init() {
        setupControlMessageBinding()
    }
}

extension SearchTypeManager {
    func setupControlMessageBinding() {
        bindControlMessage{ [weak self] message in
            switch message {
            case .changeSearchType(let type):
                withAnimation {
                    self?.type = type
                }                                    
            default:
                return
            }
        }
    }
}
