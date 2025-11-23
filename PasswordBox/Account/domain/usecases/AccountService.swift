//
//  SiteService.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver

protocol AccountService {
    func save(_ request: CreateAccountRequest)
    func fetchAll() async -> [Account]
    func delete(_ siteId: String)
}

class DefaultAccountService: AccountService {
    @Injected var repository: AccountRepository
    
    func save(_ request: CreateAccountRequest) {
        let account = Account(
            sitename: request.sitename,
            username: request.username,
            password: request.password,
            pin: request.pin,
            memo: request.memo
        )
        
        repository.save(account)
    }
    
    func fetchAll() async -> [Account] {
        await repository.fetch()
    }
    
    func delete(_ siteId: String) {
        repository.delete(id: siteId)
    }
}
