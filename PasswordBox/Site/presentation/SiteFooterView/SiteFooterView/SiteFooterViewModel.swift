//
//  SiteFooterViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/3/25.
//

import SwiftUI
import Foundation
import Resolver
import Combine


class SiteFooterViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var isSearchBarActive: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
    }
    
    func changeSearchBarActive() {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.isSearchBarActive.toggle()
        }
    }
    
    func setupControlMessageBinding() {
        bindControlMessage { [weak self] message in
            switch message {
            case .changeSearchBarState:
                self?.changeSearchBarActive()
            default:
                return
            }
        }
    }
}
