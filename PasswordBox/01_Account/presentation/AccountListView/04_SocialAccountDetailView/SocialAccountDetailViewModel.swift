//
//  SocialAccountViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation
import Resolver
import Combine

class SocialAccountDetailViewModel: ObservableObject {
    @Injected var controlSubject: PassthroughSubject<ControlMessage, Never>
    var socialAccount: SocialAccount
    
    init(socialAccount: SocialAccount) {
        self.socialAccount = socialAccount
    }
    
    func didSet() {
        controlSubject.send(.focusSearchBar)
    }
}
