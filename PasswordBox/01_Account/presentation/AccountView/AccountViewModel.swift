//
//  SiteViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/11/25.
//

import Foundation
import Resolver
import Combine
import CoreData

@MainActor
class AccountViewModel: ObservableObject, @MainActor ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Injected var accountSubject: PassthroughSubject<AccountMessage, Never>    
    @Injected var cloudManager: CloudManager
        
    @Published var isShowingAccountAddSheet = false
    var cancellables: Set<AnyCancellable> = []
        
    init() {        
        setupControlMessageBindng()
    }
    
    private func setupControlMessageBindng() {
        bindControlMessage { [weak self] message in
            switch message {                            
            case .toggleIsShowingAccountAddSheet:
                self?.isShowingAccountAddSheet.toggle()
            default:
                return
            }
        }
    }
}
