//
//  SiteSearchBarViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import Foundation
import Resolver
import Combine


class SiteSearchBarViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var siteSubject: PassthroughSubject<AccountMessage, Never>
    @Published var text: String = ""
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    func setupBindings() {
        $text
            .sink { [weak self] newText in
                self?.siteSubject.send(.changeSearchText(newText))
            }
            .store(in: &cancellables)
    }
    
    func sendFocuseState(by focusState: Bool) {
        if !focusState {
            self.text = ""
        }
        controlSubject.send(.changeSearchBarState)
    }
}
