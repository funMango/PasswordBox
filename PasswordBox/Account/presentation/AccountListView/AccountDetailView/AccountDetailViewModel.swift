//
//  SiteDetailViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 8/18/25.
//

import Foundation
import Resolver
import Combine

class AccountDetailViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    @Published var account: Account
    @Published var isShowingPasswordAddSheet: Bool = false
    var cancellables: Set<AnyCancellable> = []
    
    init(account: Account) {
        self.account = account
    }
    
    func toggleSheet() {
        isShowingPasswordAddSheet.toggle()
    }
    
    func didSet() {
        controlSubject.send(.focusSearchBar)
    }
}
