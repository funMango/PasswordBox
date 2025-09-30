//
//  SocialAccountViewModel.swift
//  PasswordBox
//
//  Created by 이민호 on 10/1/25.
//

import Foundation

class SocialAccountDetailViewModel: ObservableObject {
    var socialAccount: SocialAccount
    
    init(socialAccount: SocialAccount) {
        self.socialAccount = socialAccount
    }
}
