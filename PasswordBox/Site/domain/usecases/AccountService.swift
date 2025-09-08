//
//  SiteService.swift
//  PasswordBox
//
//  Created by 이민호 on 8/14/25.
//

import Foundation
import Resolver

protocol AccountService {
    func save(name: String)
    func fetchAll() -> [Account] 
    func delete(_ siteId: String)
}

class DefaultAccountService: AccountService {
    @Injected var repository: AccountRepository
    
    func save(name: String) {
        let site = Account(siteName: name)
        repository.save(site)
    }
    
    func fetchAll() -> [Account] {
        repository.fetch()
    }
    
    func delete(_ siteId: String) {
        repository.delete(siteId: siteId)
    }
}
