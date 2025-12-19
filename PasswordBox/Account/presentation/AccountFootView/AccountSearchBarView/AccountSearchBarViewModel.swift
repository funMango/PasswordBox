//
//  SiteSearchBarViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import Foundation
import Resolver
import Combine

@MainActor
class AccountSearchBarViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var type: SearchType = .normal    
    @Published var text: String = ""
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
        setupControlMessageBindings()
    }
    
    func setupBindings() {
        $text
            .sink { [weak self] newText in
                self?.accountSubject.send(.changeSearchText(newText))
            }
            .store(in: &cancellables)
    }
    
    func searchBarTapped() {
        controlSubject.send(.changeSearchType(.search))
    }
    
    func canfocus() -> Bool {
        return self.type == .search
    }
    
    func setupControlMessageBindings() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchType(let type):
                self.type = type
                if type == .normal { self.text = "" }
            default:
                return
            }
        }
    }
}


