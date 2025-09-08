//
//  PasswordAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation
import Resolver
import Combine

class PasswordAddViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var pin: String = ""
    @Published var memo: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    var isValid: Bool {
        return !name.isEmpty && !password.isEmpty
    }
    
    init() {
        sendIsValidState()
    }
    
    func sendIsValidState() {
        Publishers.CombineLatest($name, $password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .removeDuplicates()
            .sink { [weak self] valid in
                self?.controlSubject.send(.changeAccountInfoState(valid))
            }
            .store(in: &cancellables)
    }
}

