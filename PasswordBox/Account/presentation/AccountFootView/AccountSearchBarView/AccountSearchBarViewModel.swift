//
//  SiteSearchBarViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import Foundation
import Resolver
import Combine

class AccountSearchBarViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>
    @Published var searchTypeManager: SearchTypeManager = Resolver.resolve()
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
        return searchTypeManager.type == .search
    }
    
    func setupControlMessageBindings() {
        bindControlMessage{ [weak self] message in
            guard let self else { return }
            switch message {
            case .changeSearchType(let type):
                if type == .normal { self.text = "" }
            default:
                return
            }
        }
    }
}


