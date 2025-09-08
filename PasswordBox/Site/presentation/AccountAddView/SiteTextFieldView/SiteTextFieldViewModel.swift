//
//  SiteTextFieldViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/8/25.
//

import Foundation
import Resolver
import Combine

class SiteTextFieldViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var siteName: String = ""
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
    }
            
    func sendControlMessage() {
        controlSubject.send(.activateSiteTextField)
    }
    
    func setupControlMessageBinding() {
        bindControlMessage { [weak self] message in
            switch message {
            case .createSite(let siteName):
                self?.siteName = siteName
            default:
                return
            }
        }
    }
}


