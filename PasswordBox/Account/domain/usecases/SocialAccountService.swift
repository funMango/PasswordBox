//
//  SocialAccountService.swift
//  PasswordBox
//
//  Created by 이민호 on 9/25/25.
//

import Foundation
import Resolver

protocol SocialAccountService {
    func save(_ request: CreateSocialAccountRequest)
    func fetchAll() async -> [SocialAccount]
    func delete(id: String)
}

class DefaultSocialAccountService: SocialAccountService {
    @Injected var repository: SocialAccountRepository
    
    func save(_ request: CreateSocialAccountRequest) {
        let socialAccount = SocialAccount(
            sitename: request.sitename,
            socialSitename: request.socialSitename,
            username: request.username,
            accountId: request.accountId
        )
        
        repository.save(socialAccount)
    }
    
    func fetchAll() async -> [SocialAccount] {
        await repository.fetch()
    }
    
    func delete(id: String) {
        repository.delete(id: id)
    }
}
