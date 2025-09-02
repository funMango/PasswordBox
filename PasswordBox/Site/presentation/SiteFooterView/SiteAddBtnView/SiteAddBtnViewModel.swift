//
//  SiteAddBtnViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import Foundation
import Resolver
import Combine

class SiteAddBtnViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var isSearchBarActive: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        
    }
    
    func toggleIsShowingSiteAddSheet() {
        controlSubject.send(.toggleIsShowingSiteAddSheet)
    }
    
    func setupControlMessageBinding() {
        bindControlMessage { message in
            switch message {
            case .activateSearchBar:
                self.isSearchBarActive.toggle()
            default:
                return
            }
        }
    }
}
