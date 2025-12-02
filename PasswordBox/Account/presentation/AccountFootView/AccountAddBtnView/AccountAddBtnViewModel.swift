//
//  SiteAddBtnViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 9/2/25.
//

import SwiftUI
import Foundation
import Resolver
import Combine

class AccountAddBtnViewModel: ObservableObject, ControlMessageBindable {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var searchTypeManager: SearchTypeManager = Resolver.resolve()
    @Published var searchType: SearchType = .normal    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupSearchTypeBinding()
    }
        
    func toggleIsShowingAccountAddSheet() {
        controlSubject.send(.toggleIsShowingAccountAddSheet)
    }
    
    func toggleIsShowingSocialAccountAddSheet() {
        controlSubject.send(.toggleIsShowingSocialAccountSheet)
    }
    
    func tappedCloseButton() {
        controlSubject.send(.changeSearchType(.normal))
    }
    
    func setupSearchTypeBinding() {
        searchTypeManager.$type
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                withAnimation {
                    self?.searchType = newValue
                }
            }
            .store(in: &cancellables)
    }
}
