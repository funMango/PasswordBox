//
//  SiteAddViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/12/25.
//

import Foundation
import Resolver
import Combine

class AccountAddViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var AccountService: AccountService
    @Published var siteName: String = ""
    @Published var isSiteSearchActive: Bool = false
    @Published var isInputValid: Bool = false
    
    var canSave: Bool {
        !siteName.isEmpty && isInputValid
    }
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupControlMessageBinding()
    }
            
    func deactivatePage() {
        reset()
        controlSubject.send(.toggleIsShowingAccountAddSheet)
    }
    
    func saveSite() {
        AccountService.save(name: siteName)
        deactivatePage()
    }
    
    private func reset() {
        self.siteName = ""        
    }
    
    private func setupControlMessageBinding() {
        bindControlMessage { [weak self] message in
            switch message {
            case .activateSiteTextField:
                self?.isSiteSearchActive = true
            case .createSite(let siteName):
                self?.siteName = siteName
                self?.isSiteSearchActive.toggle()
            case .changeAccountInfoState(let state):
                DispatchQueue.main.async {
                    self?.isInputValid = state
                }                
            default:
                return
            }
        }
    }
    
    
}
