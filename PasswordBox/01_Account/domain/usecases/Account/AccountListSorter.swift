//
//  AccountListManager.swift
//  PasswordBox
//
//  Created by 이민호 on 11/21/25.
//

import Foundation
import Resolver
import Combine

protocol AccountListSorter {
    func sort(accounts: [Account]) async throws -> [Account]
    func sort(accounts: [Account], order: AccountOrder, orderBy: AccountOrderBy) -> [Account]
}

class DefaultAccountListSorter: AccountListSorter {
    @Injected var userService: UserService
    
    func sort(accounts: [Account]) async throws -> [Account] {
        let (order, orderBy) = try await userService.getOrderAndOrderBy()        
        
        switch orderBy {
        case .title:
            switch order {
            case .ascending:
                return accounts.sorted { $0.sitename < $1.sitename }
            case .descending:
                return accounts.sorted { $0.sitename > $1.sitename }
            }
        case .createDate:
            switch order {
            case .ascending:
                return accounts.sorted { $0.createDate < $1.createDate }
            case .descending:
                return accounts.sorted { $0.createDate > $1.createDate }
            }
        case .updateDate:
            switch order {
            case .ascending:
                return accounts.sorted { $0.updateDate < $1.updateDate }
            case .descending:
                return accounts.sorted { $0.updateDate > $1.updateDate }
            }
        }
    }
    
    func sort(accounts: [Account], order: AccountOrder, orderBy: AccountOrderBy) -> [Account] {
        
        switch orderBy {
        case .title:
            switch order {
            case .ascending:
                return accounts.sorted { $0.sitename < $1.sitename }
            case .descending:
                return accounts.sorted { $0.sitename > $1.sitename }
            }
        case .createDate:
            switch order {
            case .ascending:
                return accounts.sorted { $0.createDate < $1.createDate }
            case .descending:
                return accounts.sorted { $0.createDate > $1.createDate }
            }
        case .updateDate:
            switch order {
            case .ascending:
                return accounts.sorted { $0.updateDate < $1.updateDate }
            case .descending:
                return accounts.sorted { $0.updateDate > $1.updateDate }
            }
        }
    }
}
